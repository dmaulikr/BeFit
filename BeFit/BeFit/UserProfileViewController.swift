//
//  UserProfileViewController.swift
//  BeFit
//
//  Created by MTLab on 16/12/2016.
//  Copyright © 2016 Kristijan Gašljević. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var fullUserNametxt: UITextField!
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet var userDoBdp: UIDatePicker!
    @IBOutlet var userCountrysb: UIPickerView!
    @IBOutlet var usesrHeighttxt: UITextField!
    @IBOutlet var userWeighttxt: UITextField!
    @IBOutlet var maleBtn: UIButton!
    @IBOutlet var femaleBtn: UIButton!
    @IBOutlet var goalWeighttxt: UITextField!
    @IBOutlet var SaveChangesBtn: UIButton!
    var countries:[String] = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator.startAnimating()
        var request = URLRequest(url: URL(string: "http://befitapp.esy.es/userdetails.php")!);
        request.httpMethod = "POST";
        let postString = "userid=\(user.userID)";
        countries=["Croatia", "Slovenia", "USA", "Mexico", "Spain", "Portugal", "United Kingdom", "Austria", "Colombia", "Venezuela", "Costa Rica", "China"];
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            //response form the server
            let responseString = String(data: data!, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            //parsing server response to JSON
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let loginStatus = parsedData["status"] as! String
                print("parsedData - status: = \(loginStatus)")
                
                if(loginStatus=="success"){
                    user.fullUserName=parsedData["name"] as! String
                    user.gender=parsedData["gender"] as! String
                    let userD = parsedData["birthDate"] as! String
                    let dateForm = DateFormatter();
                    dateForm.dateFormat = "yyyy-MM-dd";
                    user.userDOB = dateForm.date(from: userD)!;
                    user.userDOB = user.userDOB+3601
                    
                    user.userCountry=parsedData["country"] as! String
                    let userH = parsedData["height"] as! String
                    user.userHeight = Int(userH)!
                    let userW = parsedData["weight"] as! String
                    user.userWeight = Int(userW)!
                    let userG = parsedData["goal"] as! String
                    user.userGoalWeight = Int(userG)!
                }
                self.actIndicator.stopAnimating();
                self.showUserData();
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChangedData(){
        //set user data on changed values
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    @IBAction func maleBtnClick(_ sender: Any) {
        maleBtn.backgroundColor = UIColor.white;
        femaleBtn.backgroundColor=UIColor.clear;
        user.gender = "M";
    }
    @IBAction func femaleBtnClick(_ sender: Any) {
        maleBtn.backgroundColor = UIColor.clear;
        femaleBtn.backgroundColor=UIColor.white;
        user.gender = "F";
    }
    func showUserData(){
        //fill in fields with user details
        //userDoBdp.date = user.userDOB;
        fullUserNametxt.text = user.fullUserName;
        usesrHeighttxt.text = String(user.userHeight)
        userWeighttxt.text = String(user.userWeight)
        self.userCountrysb.delegate = self
        self.userCountrysb.dataSource = self
        if(user.gender=="F"){
            maleBtn.backgroundColor = UIColor.clear;
            femaleBtn.backgroundColor=UIColor.white;
        }else{
            maleBtn.backgroundColor = UIColor.white;
            femaleBtn.backgroundColor=UIColor.clear;
        }
        let indexDrzave = countries.index(of: user.userCountry);
        userCountrysb.selectRow(indexDrzave!, inComponent: 0, animated: true);
        goalWeighttxt.text = String(user.userGoalWeight)
        
        //userDoBdp.date=user.userDOB;
        
    }
    func saveData(){
        //save values from fields to user variables
        user.fullUserName = fullUserNametxt.text!
        user.userWeight = Int(userWeighttxt.text!)!
        user.userHeight = Int(usesrHeighttxt.text!)!
        user.userDOB = userDoBdp.date;
        user.userCountry = countries[userCountrysb.selectedRow(inComponent: 0)];
        user.userGoalWeight =  Int(goalWeighttxt.text!)!
        
        
        if(user.userGoalWeight<user.userWeight){
            //program mrsavljenja
            user.selectedProgram=1;
        }else if(user.userGoalWeight==user.userWeight){
            //zadrži trenutnu težinu
            user.selectedProgram=2;
        }else{
            //dobivanje težine
            user.selectedProgram=3;
        }
        
        let dateFormater  =  DateFormatter();
        dateFormater.dateFormat="yyyy-MM-dd";
        let userDOBStringani = dateFormater.string(from: userDoBdp.date);
        var request = URLRequest(url: URL(string: "http://befitapp.esy.es/saveuserdetails.php")!);
        request.httpMethod = "POST";
        let postString = "fullname=\(user.fullUserName)&weight=\(user.userWeight)&height=\(user.userWeight)&goalweight=\(user.userGoalWeight)&programid=\(user.selectedProgram)&userid=\(user.userID)&country=\(user.userCountry)&dob=\(userDOBStringani)&gender=\(user.gender)";
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let dataStatus = parsedData["status"] as! String
                
                if(dataStatus=="success"){
                    
                }
                
                self.showUserData();
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume();
        
    }
    @IBAction func saveChangesBtnClick(_ sender: Any) {
        saveData();
        
        
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
