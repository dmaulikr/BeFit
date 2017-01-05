//
//  User.swift
//  BeFit
//
//  Created by MTLab on 18/12/2016.
//  Copyright © 2016 Kristijan Gašljević. All rights reserved.
//

import Foundation

class User {
    var userID:String = "";
    var userName:String = "";
    var fullUserName:String = "";
    var gender:String = "";
    var userDOB:Date=Date.init(timeIntervalSinceNow: 0);
    var userCountry:String = "";
    var userWeight:Int = 0;
    var userHeight:Int = 0;
    var userGoalWeight:Int = 0;
    var selectedProgram:Int = 1;
    
    func autenthicateUser(usrname:String, pass:String) -> (String,String) {
        //user login
        var status:String="";
        var description:String="";
        return (status, description);
    }
    func getUserDetails(){
        //get data from server
        
    }
    func getuserDOB() -> Date{
        return userDOB;
    }
    
}
