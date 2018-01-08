//
//  ViewController.swift
//  Spacetagram
//
//  Created by Erica on 1/6/18.
//  Copyright © 2018 Erica. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
       let object = PFObject(className: "test")
        object["name"] = "Erica"
        object["lastname"] = "Gutierrez"
        object.saveInBackground { (success, error) -> Void in
            if error == nil {
                print("Saved in server")
            } else {
                print(error!)
            }
            
            
        }
    
    
        
        }
    
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
 

