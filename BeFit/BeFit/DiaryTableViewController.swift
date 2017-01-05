//
//  DiaryTableViewController.swift
//  BeFit
//
//  Created by MTLab on 04/01/2017.
//  Copyright © 2017 Kristijan Gašljević. All rights reserved.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    
    var sections = ["Meals", "Exercises"];
    var meals = [String]();
    var caloriesMeals = [String]();
    var exercises = ["trčanje", "plivanje", "trbušnjaci", "sklekovi", "nogomet"];
    var caloriesExercises = ["150", "300", "100", "120", "450"];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get users meals
        var request = URLRequest(url: URL(string: "http://befitapp.esy.es/foods/getfoodrecordbyuser.php")!);
        request.httpMethod = "POST";
        
        let postString = "userid=\(user.userID)";
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            //response form the server
            let responseString = String(data: data!, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            //parsing server response to JSON
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                
                //print (parsedData)
                
                //meals status end description
                let mealsStatus = parsedData["status"] as! String
                print("parsedData - status: = \(mealsStatus)")
                
                
                if(mealsStatus=="success"){
                    if let mealsList = parsedData["description"] {
                        for index in 0...mealsList.count {
                            let aObject = mealsList[index] as! [String :AnyObject]
                            
                            self.meals.append(aObject["foodName"] as! String);
                            self.caloriesMeals.append(aObject["cal"] as! String);
                        }
                    }
                }
                
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume();        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // return the title for each section
        return self.sections[section];
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return self.sections.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows for each section
        if section == 0 {
            return self.meals.count;
        }
        else {
            return self.exercises.count;
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        if indexPath.section == 0 {
            cell.textLabel?.text = meals[indexPath.row];
            cell.detailTextLabel?.text = caloriesMeals[indexPath.row];
        }
        else {
            cell.textLabel?.text = exercises[indexPath.row];
            cell.detailTextLabel?.text = caloriesExercises[indexPath.row];
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
