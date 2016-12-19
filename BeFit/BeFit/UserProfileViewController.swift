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
    @IBOutlet var userDoBdp: UIDatePicker!
    @IBOutlet var userCountrysb: UIPickerView!
    @IBOutlet var usesrHeighttxt: UITextField!
    @IBOutlet var userWeighttxt: UITextField!
    @IBOutlet var maleBtn: UIButton!
    @IBOutlet var femaleBtn: UIButton!
    
    var countries:[String] = [String]();
    override func viewDidLoad() {
        super.viewDidLoad()
        userDoBdp.date = user.getuserDOB();
        fullUserNametxt.text = user.fullUserName;
        usesrHeighttxt.text = String(user.userHeight)
        userWeighttxt.text = String(user.userWeight)
        self.userCountrysb.delegate = self
        self.userCountrysb.dataSource = self
        countries=["Croatia", "Slovenia", "USA", "Mexico", "Spain", "Portugal", "United Kingdom", "Austria", "Colombia", "Venezuela", "Costa Rica", "China"];
        
        if(user.gender=="F"){
            maleBtn.backgroundColor = UIColor.clear;
            femaleBtn.backgroundColor=UIColor.white;
        }else{
            maleBtn.backgroundColor = UIColor.white;
            femaleBtn.backgroundColor=UIColor.clear;
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
