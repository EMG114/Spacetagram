//
//  SignUpViewController.swift
//  Spacetagram
//
//  Created by Erica on 1/7/18.
//  Copyright © 2018 Erica. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPassTextField: UITextField!
    
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
        print("sign up")
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
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
