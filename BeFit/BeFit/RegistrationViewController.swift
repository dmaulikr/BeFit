//
//  RegistrationViewController.swift
//  BeFit
//
//  Created by MTLab on 10/11/2016.
//  Copyright © 2016 Kristijan Gašljević. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //click on button Register
    @IBAction func btnRegisterClick(_ sender: Any)
    {
        let userEmail = txtEmail.text;
        let userUsername = txtUsername.text;
        let userPassword = txtPassword.text;
        
        //check for empty fields
        if (userEmail == "" || userUsername == "" || userPassword == "")
        {
            //display alert message
            displayAlertMessage(userMessage: "All fields are required!")
            
            return;
        }
    }
    
    // click on button Login
    @IBAction func btnLoginClick(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil);
    }
    
    func displayAlertMessage (userMessage:String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self .present(myAlert, animated: true, completion: nil);
        
        
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
