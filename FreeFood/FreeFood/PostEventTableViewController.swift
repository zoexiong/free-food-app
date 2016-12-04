//
//  PostEventTableViewController.swift
//  FreeFood
//
//  Created by Xuan Liu on 2016/11/28.
//  Copyright © 2016年 Xuan Liu. All rights reserved.
//

import UIKit

class PostEventTableViewController: UITableViewController {
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var eventLocation: UITextField!
    
    @IBOutlet weak var eventZipcode: UITextField!
    
    @IBOutlet weak var eventURL: UITextField!
    
    @IBOutlet weak var eventDescription: UITextField!
    
    var strDate: String=""
    var pickerView = UIDatePicker()
    
    //add alert
    func alert(){
        let alertController:UIAlertController = {
            return UIAlertController(title: "incomplete", message: "You must fill all the required fields (indicated by *) to post the event", preferredStyle: UIAlertControllerStyle.alert)
        }()
        
        let okAlert:UIAlertAction = UIAlertAction(title: "alert", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in NSLog("submit failed")}
        
        alertController.addAction(okAlert)
        
        self.present(alertController, animated: true, completion: nil);
    }


    //Todo:need to add a duration of event
    @IBAction func pickDateAction(_ sender: Any) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            strDate = dateFormatter.string(from: pickerView.date)
            pickerTextField.text = strDate
    }
    @IBAction func submitEvent(_ sender: Any) {
        
        //get the values in form and construct JSON
        let name = eventName.text
        let dateTime = pickerTextField.text
        let location = eventLocation.text
        let zipcode = eventZipcode.text
        let url = eventURL.text
        let description = eventDescription.text
        
        //test if user completed required fields
        if name != "" {
            if dateTime != ""{
                if location != ""{
                    if zipcode != ""{
                        let testObject:AnyObject = [
                            "event_name":name,
                            "location": location,
                            "zip_code": zipcode,
                            "date":"11/16/2016",
                            "start_time": "12:30",
                            "end_time": "13:30",
                            "foods": ["pizza","coke"],
                            "description":description,
                            "url": url
                            ] as AnyObject

                        let valid = JSONSerialization.isValidJSONObject(testObject) // should be true
                        print(testObject)
                        //post JSON to server
                        
                        //submit success alert and back to main screen
                        } else{
                        alert()
                    }
                } else {
                    alert()
                }
            } else {
                alert()
            }
        }
    }
    
    
    
    let foodItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a reuseable cell for each food item displayed in the food list
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "foodItemCell")
        //remove additional unecessary cells
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
        //set up text color
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = UIColor.gray
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
        //set up date picker for the event time text field
        pickerView = UIDatePicker()
        pickerTextField.inputView = pickerView
    }
    
    
//    var dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//    var strDate = dateFormatter.stringFromDate(myDatePicker.date)
//    self.selectedDate.text = strDate
//    
    
    
    //2 sections in total
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //the 1st section has 6 rows for basic event info and 1 row to edit food items, the 2nd section (with index 1) has 1 row to dynamically populate multiple rows for a list of food items that the user adds
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            if section == 1 {
                return foodItems.count
            }else{
                return 7
            }
    }
    
    
    //cell set up
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            //only the 2nd section (with index 1) is dynamic
            if indexPath.section == 1 {
                //when it reaches the dynamic section, generate the reusable cell identified by "foodItemCell", which we init it at the beginning of this code file
                let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell",for: indexPath)
                //disable cell selection highlight
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                //fetch the corresponding name of the food item and populate many rows
                cell.textLabel?.text = foodItems[indexPath.row]
                //disable the selected row highlight
                                return cell
            }else{ //for the 1st section (the more static one)
//                let cellS = super.tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//                cellS.selectionStyle = .none
                return super.tableView(tableView, cellForRowAt: indexPath)
            }
    }
    
    //set up the dynamic sectoin's row's height
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 44
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    //data source and delegate, dynamically insert new row when we get new data
    override func tableView(_ tableView: UITableView,
                            indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1{
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        }else{
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
