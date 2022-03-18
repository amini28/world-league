//
//  HomeViewController.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 12/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var leagues:[LeaguesData] = []
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self;
        tableview.dataSource = self;
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getData(){
        showLoading()
        let stringUrl = "https://api-football.azharimm.tk/leagues"
        
        var request = URLRequest(url: URL(string: stringUrl)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            guard let data = data else {return}
            let result = try! JSONDecoder().decode(Leagues.self, from: data)
            
            if(result.status == true){
                DispatchQueue.main.async { [self] in
                    dismissLoading()
                    leagues = result.data
                    tableview.reloadData()
                }
            }
        }
        
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? ClubListViewController {
            if let indexpath = tableview.indexPathForSelectedRow{
                nextViewController.id = leagues[indexpath.row].id
                nextViewController.urllogos = leagues[indexpath.row].logos.dark
            }
        }
    }
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"homeCell") as! HomeTableViewCell
        
        cell.label.text = leagues[indexPath.row].name
        
        if let urls = URL(string: leagues[indexPath.row].logos.light){
            cell.logos.load(url:urls)
        }
        
        return cell
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIViewController{
    private static let alert  = UIAlertController(title: nil, message: "Please wait..", preferredStyle: .alert)
    
    func showLoading(){
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        UIViewController.alert.view.addSubview(loadingIndicator)
        self.present(UIViewController.alert, animated: true)
    }
    
    func dismissLoading(){
        UIViewController.alert.dismiss(animated: true, completion: nil)
    }
}
