//
//  LoginViewController.swift
//  ConcentrationGame
//
//  Created by 17 on 11/8/19.
//  Copyright © 2019 17. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(with:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
    }
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func handleLogin(_ sender: UIButton) {
        if usernameLabel.text != User.shared.username || passwordLabel.text != User.shared.password {
            let alert = UIAlertController(title: "Wrong Login or Password",
                                          message: "Please try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc func keyboardWillShow(with notification: NSNotification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        bottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        usernameLabel.text = nil
        passwordLabel.text = nil
        
        usernameLabel.becomeFirstResponder()
    }

}
