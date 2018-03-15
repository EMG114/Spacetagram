//
//  SignInViewController.swift
//  Spacetagram
//
//  Created by Erica on 1/7/18.
//  Copyright © 2018 Erica. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
    
    @IBOutlet weak var appLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appLabel.font = UIFont(name: "Pacifico", size: 25)
        
        appLabel.frame = CGRect(x: 10, y: 80, width: self.view.frame.size.width - 20, height: 50)
        usernameTextField.frame = CGRect(x: 10, y: appLabel.frame.origin.y + 70, width: self.view.frame.size.width - 20, height: 30)
        passwordTextField.frame = CGRect(x: 10, y: usernameTextField.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        forgotButton.frame = CGRect(x: 10, y: passwordTextField.frame.origin.y + 30, width: self.view.frame.size.width - 20, height: 30)
        
        signInButton.frame = CGRect(x: 20, y: forgotButton.frame.origin.y + 40, width: self.view.frame.size.width / 4, height: 30)
        signInButton.layer.cornerRadius = signInButton.frame.size.width / 20
        
        signUpButton.frame = CGRect(x: self.view.frame.size.width - self.view.frame.size.width / 4 - 20, y: signInButton.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
        signUpButton.layer.cornerRadius = signUpButton.frame.size.width / 20
        
        
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
    
    }

    // hide keyboard func
    @objc func hideKeyboard(_ recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Please", message: "Fill out all fields", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
    PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) -> Void in
        if error == nil {
            UserDefaults.standard.set(user?.username, forKey: "username")
            UserDefaults.standard.synchronize()
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.login()
        }
        } 
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
