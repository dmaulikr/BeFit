//
//  DiaryTableViewController.swift
//  BeFit
//
//  Created by MTLab on 04/01/2017.
//  Copyright © 2017 Kristijan Gašljević. All rights reserved.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    
    var sections = ["Daily calorie meter", "Meals","Add new Meal", "Exercises", "Add new Exercise"];
    var meals = [String]();
    var caloriesMeals = [String]();
    var exercises = ["trčanje", "plivanje", "nogomet"];
    var caloriesExercises = ["150", "300", "450"];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get users meals
        var request = URLRequest(url: URL(string: "http://befitapp.esy.es/foods/getfoodrecordsbyuser.php")!);
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
                    let mealsList = parsedData["description"] as! [AnyObject];
                    print("parsedData - description: =\(mealsList)");
                
                
                print("parsedData - prvi zapis: =\(mealsList[0])");
                    for meal in mealsList {
                        let mealName = meal["foodName"] as! String;
                        self.meals.append(mealName);
                        
                        let mealCalories = meal["cal"] as! String;
                        self.caloriesMeals.append(mealCalories);
                        print("meal - name: =\(mealName)");
                        
                        self.tableView.reloadData();
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume();
        // Uncomment the following line to preserve selection between presentations
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
        if (section == 1 || section == 3){
            return self.sections[section];
        }
        return nil;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0 || section == 1 || section == 3){
            return 60.0;
        }

        return 0;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return self.sections.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows for each section
        if section == 1 {
            return self.meals.count;
        }
        else if section == 3{
            return self.exercises.count;
        }
        else {
            return 1;
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140.0;
        }
        else {
            return UITableViewAutomaticDimension;
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDailyCalorieMeter", for: indexPath) as! DailyCalorieMeterTableViewCell;
            
            cell.labelDailyGoaltxt.text = "Daily Goal";
            cell.labelMealstxt.text = "Meals";
            cell.labelExercisetxt.text = "Exercise";
            cell.labelRemainingtxt.text = "Remaining";
            
            cell.labelCounterDailyGoal.text = "2500";
            cell.labelCounterMeals.text = "1020";
            cell.labelCounterExercise.text = "480";
            cell.labelCounterRemaining.text = "1960";
            
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = meals[indexPath.row];
            cell.detailTextLabel?.text = caloriesMeals[indexPath.row];
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellAddNewMeal", for: indexPath) as! AddNewMealTableViewCell;
            cell.labelAddNew.text = "+ Add New Meal";
            return cell;
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = exercises[indexPath.row];
            cell.detailTextLabel?.text = caloriesExercises[indexPath.row];
            return cell;
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellAddNewMeal", for: indexPath) as! AddNewMealTableViewCell;
            cell.labelAddNew.text = "+ Add New Exercise";
            return cell;
        }
        
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
