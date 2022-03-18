//
//  ClubDetailViewController.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 12/06/21.
//

import UIKit

class ClubDetailViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var klubname: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var standings:Team?
    var stats:[TeamStats] = []
    var seasionvalue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let teamstats = standings?.stats {
            stats = teamstats
        }
        if let urllogo = standings?.team.logos?[0].href {
            logo.load(url: URL(string: urllogo)!)
        }
        klubname.text = standings?.team.displayName
        location.text = standings?.team.location
        season.text = seasionvalue
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
    }
}

extension ClubDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailstatscell") as! DetailStatsTableViewCell
        
        cell.content.text = stats[indexPath.row].displayValue
        cell.title.text = stats[indexPath.row].displayName
        
        return cell
    }
    
}


