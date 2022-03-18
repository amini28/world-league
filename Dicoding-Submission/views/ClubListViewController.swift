//
//  ClubListViewController.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 12/06/21.
//

import UIKit

class ClubListViewController: UIViewController {

    @IBOutlet weak var labelSeason: UILabel!
    @IBOutlet weak var logos: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var dropDown: UITableView!
    @IBOutlet weak var viewDropDown: UIView!
    
    var id:String = ""
    var urllogos:String = ""
    var clubs:ClubData?
    var season:SeasonsData?
    var standings:[Team] = []
    
    //https://api-football.azharimm.tk/leagues/eng.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        labelSeason.text = ""
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewDropDown.addGestureRecognizer(tap)
        viewDropDown.isUserInteractionEnabled = true
        viewDropDown.layer.cornerRadius = 8
        viewDropDown.layer.borderWidth = 1
        viewDropDown.layer.borderColor = UIColor.systemGray.cgColor
        
        dropDown.layer.cornerRadius = 8
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor.systemGray.cgColor
        
        dropDown.delegate = self
        dropDown.dataSource = self
        dropDown.isHidden = true
        
        if let urls = URL(string: urllogos){
            logos.load(url:urls)
        }
        
        getSessionData(id:id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? ClubDetailViewController {
            if let indexpath = tableview.indexPathForSelectedRow{
                nextViewController.standings = standings[indexpath.row]
                nextViewController.seasionvalue = labelSeason.text ?? ""
            }
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dropDown.isHidden = false
    }
    
    func getClubData(id:String, sesson:Int){
        let stringUrl = "https://api-football.azharimm.tk/leagues/"+id+"/standings?season="+String(sesson)+"&sort=asc"
        var request = URLRequest(url: URL(string: stringUrl)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data else {return}
            let result = try! JSONDecoder().decode(Club.self, from: data)
            if(result.status == true){
                DispatchQueue.main.async { [self] in
                    clubs = result.data
                    standings = clubs!.standings
                    labelSeason.text = "Season - \(clubs?.seasonDisplay ?? String(sesson)) - \(sesson)"
                    dismissLoading()
                    dropDown.isHidden = true
                    tableview.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func getSessionData(id:String){
        showLoading()
        let stringUrl = "https://api-football.azharimm.tk/leagues/"+id+"/seasons"
        var request = URLRequest(url: URL(string: stringUrl)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data else {return}
            let result = try! JSONDecoder().decode(Seasons.self, from: data)
            if(result.status == true){
                DispatchQueue.main.async { [self] in
                    season = result.data
                    getClubData(id: id, sesson: (season?.seasons[0].year)!)
                    dropDown.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func getDataStats(type: String, stats:[TeamStats]) -> TeamStats? {
        for item in stats{
            if(item.type == type){
                return item
            }
        }
        return nil
    }
    
}

extension ClubListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dropDown {
            return season?.seasons.count ?? 0
        }
        return standings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == dropDown {
            let dropdowncell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            dropdowncell.textLabel?.text = "Season - \(String(describing: season?.seasons[indexPath.row].year))"
            return dropdowncell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankcell") as! RankTableViewCell
        
        let rank = getDataStats(type: "rank", stats: standings[indexPath.row].stats)
        let played = getDataStats(type: "gamesplayed", stats: standings[indexPath.row].stats)
        let gd = getDataStats(type: "pointdifferential", stats: standings[indexPath.row].stats)
        let points = getDataStats(type: "points", stats: standings[indexPath.row].stats)
        
        cell.rank.text = rank?.displayValue
        cell.played.text = played?.displayValue
        cell.goals.text = gd?.displayValue
        cell.points.text = points?.displayValue
        
        if let urllogo = standings[indexPath.row].team.logos?[0].href {
            cell.logo?.load(url: URL(string: urllogo)!)
        }
        
        cell.klubname.text = standings[indexPath.row].team.shortDisplayName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dropDown {
            showLoading()
            getClubData(id: id, sesson: (season?.seasons[indexPath.row].year)!)
        }
    }
}
