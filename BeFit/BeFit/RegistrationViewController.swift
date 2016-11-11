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
            displayAlertMessage(userMessage: "All fields are required!", status: "error")
            return;
        }
        
        //send data to server
        var request = URLRequest(url: URL(string: "http://befitapp.esy.es/register.php")!);
        request.httpMethod = "POST";
        
        let postString = "email=\(userEmail!)&username=\(userUsername!)&password=\(userPassword!)";
        
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            //response from the server
            let responseString = String(data: data!, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            //parsing server response to JSON
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
                    
                    //print(parsedData)
                    
                    //registration status and description
                    let registrationStatus = parsedData["status"] as! String
                    print("parsedData - status: = \(registrationStatus)")
                    
                    let registrationDescription = parsedData["description"] as! String
                    print("parsedData - description: = \(registrationDescription)")
                    
                    DispatchQueue.main.async {
                        self.displayAlertMessage(userMessage: registrationDescription, status: registrationStatus)
                    }
                } catch let error as NSError {
                    print(error)
                }
            
            
        
        }
        task.resume()
        
        //display message of success or error
        
    }
    // click on button Login
    @IBAction func btnLoginClick(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil);
    }
    
    //function for displaying a message
    func displayAlertMessage (userMessage:String, status:String)
    {
        //if status == error stay on registration form and display error message
        if (status == "error")
        {
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
            
            myAlert.addAction(okAction);
            
            self .present(myAlert, animated: true, completion: nil);
        }
        else //if status == success display message and redirect to login form
        {
            let myAlert = UIAlertController(title: "Information", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
            
            myAlert.addAction(okAction);
            
            self.present(myAlert, animated: true, completion: nil);
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
