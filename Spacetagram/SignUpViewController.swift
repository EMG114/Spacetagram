//
//  SignUpViewController.swift
//  Spacetagram
//
//  Created by Erica on 1/7/18.
//  Copyright © 2018 Erica. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    //reset default size
   var scrollViewHeight: CGFloat = 0
    
    //keyboard frame size
   var keyboard = CGRect()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //scrollview frame size
        scrollview.frame = CGRect(0,0,self.view.frame.width, self.view.frame.height)
        scrollview.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollview.frame.size.height
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardTapped(recognizer:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
       
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        
        let avatarTap = UITapGestureRecognizer(target: self, action:#selector(self.loadImg(recognizer:)))
        avatarTap.numberOfTapsRequired = 1
        self.avatarImage.isUserInteractionEnabled = true
        self.avatarImage.addGestureRecognizer(avatarTap)
        
        
        // alignment
        avatarImage.frame = CGRect(x: self.view.frame.size.width / 2 - 40, y: 40, width: 80, height: 80)
        usernameTextField.frame = CGRect(x: 10, y: avatarImage.frame.origin.y + 90, width: self.view.frame.size.width - 20, height: 30)
        passwordTextField.frame = CGRect(x: 10, y: usernameTextField.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        repeatPassTextField.frame = CGRect(x: 10, y: passwordTextField.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        emailTextField.frame = CGRect(x: 10, y: repeatPassTextField.frame.origin.y + 60, width: self.view.frame.size.width - 20, height: 30)
        fullnameTextField.frame = CGRect(x: 10, y: emailTextField.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        descriptionTextField.frame = CGRect(x: 10, y: fullnameTextField.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        websiteTextField.frame = CGRect(x: 10, y: descriptionTextField.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        
        signUpButton.frame = CGRect(x: 20, y: websiteTextField.frame.origin.y + 50, width: self.view.frame.size.width / 4, height: 30)
        signUpButton.layer.cornerRadius = signUpButton.frame.size.width / 20
        
        cancelButton.frame = CGRect(x: self.view.frame.size.width - self.view.frame.size.width / 4 - 20, y: signUpButton.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
        cancelButton.layer.cornerRadius = cancelButton.frame.size.width / 20
        
        // background
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        background.image = UIImage(named: "")
        background.layer.zPosition = -1
        self.view.addSubview(background)
        
    }
    
    @objc func loadImg(recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    @objc internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
        
        avatarImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @objc func hideKeyboardTapped(recognizer:UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
        }
    
   @objc func showKeyboard(notification:NSNotification){
        
        //define keyboard size
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        
        UIView.animate(withDuration: 0.4) { () -> Void in
            self.scrollview.frame.size.height = self.scrollViewHeight - self.keyboard.height
        }
        
    }
    
    
    
  @objc func hideKeyboard(notification:NSNotification){
        
        UIView.animate(withDuration: 0.4) { () -> Void in
            self.scrollview.frame.size.height = self.view.frame.height
            
        }
        
    }
    
    
    
    

    @IBAction func signUpButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        
        if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (repeatPassTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (fullnameTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "PLEASE", message: "Fill out ALL required fields", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler:nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        if passwordTextField.text != repeatPassTextField.text {
            let alert = UIAlertController(title: "PASSWORD", message: "do not match", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler:nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        let user = PFUser()
        user.username = usernameTextField.text?.lowercased()
        user.email = emailTextField.text?.lowercased()
        user.password = passwordTextField.text
        user["fullname"] = fullnameTextField.text?.lowercased()
        user["description"] = descriptionTextField.text
        user["website"] = websiteTextField.text?.lowercased()
        user["telephone"] = ""
        user["gender"] = ""
        
        let avatarData = UIImageJPEGRepresentation(avatarImage.image!, 0.5)
        let avatarFile = PFFile(name: "avatarImage.jpg", data: avatarData!)
        user["avatarPhoto"] = avatarFile
        user.signUpInBackground { (success, error) in
            if success {
                print("registered")
                
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                
        } else {
                print(error?.localizedDescription as Any)
            }

    }
        
        
    }
    
    
  
    
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        // hide keyboard when pressed cancel
        self.view.endEditing(true)
        
        self.dismiss(animated: true, completion: nil)
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
