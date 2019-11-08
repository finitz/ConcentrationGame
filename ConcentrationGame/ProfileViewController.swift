//
//  ProfileViewController.swift
//  ConcentrationGame
//
//  Created by 17 on 11/8/19.
//  Copyright © 2019 17. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var score: UILabel!
    var observation: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLogout),
                                               name: .logout,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRestart),
                                               name: .restart,
                                               object: nil)
        username.text = User.shared.username
        score.text = "Score: \(User.shared.score)"
        
        observation = User.shared.observe(\.score, options: [.new]) { [weak self] (user, change) in
            if let self = self, let newValue = change.newValue {
                print("Called \(user.score)")
                self.score.text = "Score: \(newValue)"
            }
        }

    }
    
    @IBAction func handleMore(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil,
                                            message: "What do you want to do?",
                                            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: { alert in
                                        NotificationCenter.default.post(name: .logout, object: nil)
                                    }
        ))
        
        alert.addAction(UIAlertAction(title: "Restart",
                                      style: .default,
                                      handler: { alert in
                                        NotificationCenter.default.post(name: .restart, object: nil)
                                    }
        ))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: nil))
        
        present(alert, animated: true)
        
    }
    
    @objc func handleLogout() {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func handleRestart() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension Notification.Name {
    static let logout = Notification.Name(rawValue: "log-out")
    static let restart = Notification.Name(rawValue: "restart")
}
