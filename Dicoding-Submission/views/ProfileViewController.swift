//
//  ProfileViewController.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 12/06/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileContainer: UIView!
    @IBOutlet weak var imgprofile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileContainer.layer.cornerRadius = 20;
        
        imgprofile.layer.cornerRadius = imgprofile.frame.height/2;
        imgprofile.layer.borderWidth = 1;
        imgprofile.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func actionEmail(_ sender: Any) {
        let email = "ryans.mini28@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func actionPhone(_ sender: Any) {
        let phonenumber = "6281313509750"
        let whatsapurl = URL(string:"https://wa.me/send?phone=\(phonenumber)&text=Hai%2C%20There!")!;
        if UIApplication.shared.canOpenURL(whatsapurl){
            UIApplication.shared.open(whatsapurl, options: [:], completionHandler: nil)
        }
        
        
    }
}
