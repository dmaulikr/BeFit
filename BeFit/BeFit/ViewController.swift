//
//  ViewController.swift
//  BeFit
//
//  Created by MTLab on 09/11/2016.
//  Copyright © 2016 Kristijan Gašljević. All rights reserved.
//

import UIKit

var userLoggedIn : Bool = false;
var user:User=User();

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //first show login screen
    override func viewDidAppear(_ animated: Bool) {
        if userLoggedIn == false {
            self.performSegue(withIdentifier: "loginView", sender: self);
        }
        
        
    }


}

