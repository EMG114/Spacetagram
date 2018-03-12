//
//  ResetPasswordViewController.swift
//  Spacetagram
//
//  Created by Erica on 1/7/18.
//  Copyright © 2018 Erica. All rights reserved.
//

import UIKit
import Parse

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.frame = CGRect()
        
        _ = "this is where to code"

    }

    @IBAction func resetButtonClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if (emailTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "Please", message: "enter your email", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        PFUser.requestPasswordResetForEmail(inBackground: emailTextField.text!) { (success, error) in
            if success {
                
                let alert = UIAlertController(title: "Request", message: "to change password received!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                     self.dismiss(animated: true, completion: nil)
                })
               
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                print(error?.localizedDescription as Any)
            }
            
        }
        
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
