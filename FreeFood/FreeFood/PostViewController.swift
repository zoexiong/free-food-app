//
//  PostViewController.swift
//  FreeFood
//
//  Created by Xuan Liu on 2016/11/27.
//  Copyright © 2016年 Xuan Liu. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var pickerTextField: UITextField!

    @IBOutlet weak var eventLocation: UITextField!

    @IBOutlet weak var eventFoods: UILabel!
    
    @IBOutlet weak var eventZipcode: UITextField!
    
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBOutlet weak var eventURL: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIDatePicker()
        
        pickerTextField.inputView = pickerView
               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
