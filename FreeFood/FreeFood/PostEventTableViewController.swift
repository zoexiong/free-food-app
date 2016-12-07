
//
//  PostEventTableViewController.swift
//  FreeFood
//
//  Created by Xuan Liu on 2016/11/28.
//  Copyright © 2016年 Xuan Liu. All rights reserved.
//

import UIKit

    var foodItems = [String]()

class PostEventTableViewController: UITableViewController {
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var endPickerTextField: UITextField!
    
    @IBOutlet weak var eventLocation: UITextField!
    
    @IBOutlet weak var eventZipcode: UITextField!
    
    @IBOutlet weak var eventURL: UITextField!
    
    @IBOutlet weak var eventDescription: UITextField!
    
    var startDate: String=""
    var endDate: String=""
    var pickerView = UIDatePicker()
    var endPickerView = UIDatePicker()
    
    var dateFormatter = DateFormatter()
    
    func submitFailedAlert(){
        alert(message: "You must fill all the required fields (indicated by *) to post the event", "submission failed")
    }
    
    @IBAction func submitEvent(_ sender: Any) {
        //get the values in form and construct JSON
        let name = eventName.text!
        let location = eventLocation.text!
        let zipcode = eventZipcode.text!
        let url = eventURL.text!
        let description = eventDescription.text!
        let date = String(startDate.characters.prefix(10))
        let startTime = String(startDate.characters.dropFirst(11))
        let endTime = String(endDate.characters.dropFirst(11))
        let compareResult = pickerView.date.compare(endPickerView.date as Date)
        //test if user completed required fields
        if name != "" {
            if startDate != "" && endDate != ""{
                if location != "" {
                    if zipcode != "" {
                        if selected.items.count >= 1 {
                            if compareResult == ComparisonResult.orderedAscending {
                                print("\(startTime) is earlier than \(endTime)")
                                for foodIndex in selected.items{
                                    foodItems.append(foodList.list[foodIndex])
                                }
                                let eventObject: AnyObject = [
                                    "event_name":name ,
                                    "location": location ,
                                    "zip_code": zipcode ,
                                    "date":date,
                                    "start_time": startTime,
                                    "end_time": endTime,
                                    "foods": foodItems,
                                    "description":description ,
                                    "url": url
                                    ] as AnyObject
                                
                                _ = JSONSerialization.isValidJSONObject(eventObject) // should be true
                                print(eventObject)
                                //post JSON to server
                                
                                //submit success alert and back to main screen
                                alert(message: "submit successful", "submitted!")
                                eventName.text! = ""
                                pickerTextField.text! = ""
                                endPickerTextField.text! = ""
                                eventLocation.text! = ""
                                eventZipcode.text! = ""
                                eventURL.text! = ""
                                eventDescription.text! = ""
                                foodItems = []
                                selected.items = []
                                startDate = ""
                                endDate = ""
                                do_table_refresh()
                            }else{
                                alert(message: "The end time must be later than start time", "submit failed")
                            }
                        } else{
                            alert(message: "You must enter at least one food item to post the event", "submit failed")
                        }
                    } else{
                        submitFailedAlert()
                    }
                } else {
                    submitFailedAlert()
                }
            } else {
                submitFailedAlert()
            }
        }else {
            submitFailedAlert()
        }
    }
    
    @IBAction func pickDateAction(_ sender: Any) {
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        startDate = dateFormatter.string(from: pickerView.date)
        pickerTextField.text = startDate
    }
    
    @IBAction func endPickDateAction(_ sender: Any) {
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        endDate = dateFormatter.string(from: endPickerView.date)
        endPickerTextField.text = endDate
    }
    
    //add alert
    func alert(message: String, _ submitLog:String){
        let alertController:UIAlertController = {
            return UIAlertController(title: "Submit", message: message, preferredStyle: UIAlertControllerStyle.alert)
        }()
        
        let okAlert:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in NSLog(submitLog)}
        
        alertController.addAction(okAlert)
        
        self.present(alertController, animated: true, completion: nil);
    }
    
    
    open func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            return
        })
    }
    
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
        //prevent the user from choosing a past date
        pickerView.minimumDate = NSDate() as Date
        endPickerView = UIDatePicker()
        //prevent the user from choosing a past date
        endPickerView.minimumDate = NSDate() as Date
        pickerTextField.inputView = pickerView
        endPickerTextField.inputView = endPickerView
        do_table_refresh()
        NotificationCenter.default.addObserver(self, selector: #selector(PostEventTableViewController.updateTable), name:NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
    }
    
    func updateTable() {
        do_table_refresh()
    }
    
    //2 sections in total
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //the 1st section has 7 rows for basic event info and 1 row to edit food items, the 2nd section (with index 1) has 1 row to dynamically populate multiple rows for a list of food items that the user adds
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            if section == 1 {
                return selected.items.count
            }else{
                return 8
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
                cell.textLabel?.text = foodList.list[selected.items[indexPath.row]]
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
    //disable highlight for each row
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //Change the selected background view of the cell.
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class SelectedList {
    var items : [Int]
    init(_ items:[Int]){
        self.items = items
    }
}

var selected = SelectedList([])




//func updateFoodItems(){
//    if selected.items != []{
//        foodItems = []
//        for index in selected.items{
//            foodItems.append(foodList.list[index])
//            print("foodItems:",foodItems)
//        }
//    }
//}


class FoodList{
    var list: [String]
    init(_ list:[String]){
        self.list = list
    }
}

var foodList = FoodList(["Coke","Cookie","Pizza","Rice","Pasta","Sandwich","Hamburger","Burrito","Salad"])

    
