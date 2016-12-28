//
//  LoginViewController.swift
//  BeFit
//
//  Created by MTLab on 10/11/2016.
//  Copyright © 2016 Kristijan Gašljević. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    
    //click on button Login
    @IBAction func btnLoginClicked(_ sender: Any){
        let userUsername = txtUsername.text;
        let userPassword = txtPassword.text;
        
        //check for empty fields
        if (userUsername == "" || userPassword == ""){
            displayAlertMessage(userMessage: "All fields are required", status: "error")
            return;
        }
        
        //send data to server
        var request = URLRequest(url: URL(string: "http://befitapp.esy.es/login.php")!);
        request.httpMethod = "POST";
        
        let postString = "username=\(userUsername!)&password=\(userPassword!)";
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            //response form the server
            let responseString = String(data: data!, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            //parsing server response to JSON
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                
                //print (parsedData)
                
                //login status end description
                let loginStatus = parsedData["status"] as! String
                print("parsedData - status: = \(loginStatus)")
                
                let loginDescription = parsedData["description"] as! String
                print("parsedData - description: = \(loginDescription)")
                
                //display message of success or error
                DispatchQueue.main.async {
                    self.displayAlertMessage(userMessage: loginDescription, status: loginStatus)
                }
                
            } catch let error as NSError {
            print(error)
            }
        }
        task.resume();
    }
    
    //function for displaying a message
    func displayAlertMessage(userMessage:String, status:String)
    {
        //if status == error 
        if (status == "error")
        {
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.present(myAlert, animated: true, completion: nil)
        }
        else //if status == succcess
        {
            let myAlert = UIAlertController(title: "Information", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            
            self.present(myAlert, animated: true, completion: nil)
            
            //global variable type of bool declared in TabViewController.swift 
            userLoggedIn = true;
            
            //redirect to main screen
            performSegue(withIdentifier: "tab_controller", sender: nil)
            
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
