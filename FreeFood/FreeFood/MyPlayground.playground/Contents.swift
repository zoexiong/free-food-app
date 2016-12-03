//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let savedData = ["Something": 1]

let jsonObject: [String: AnyObject] = [
    "type_id": 1 as AnyObject,
    "model_id": 1 as AnyObject,
    "transfer": [
        "startDate": "10/04/2015 12:45",
        "endDate": "10/04/2015 16:00"
    ] as AnyObject,
    "custom": savedData as AnyObject
]



let testObject:[String:AnyObject] = [
    "event_0":
        [
            "event_name":"Zillow Info Session",
            "location": "MGH 142",
            "zip_code": "98105",
            "date":"11/16/2016",
            "start_time": "12:30",
            "end_time": "13:30",
            "foods": ["pizza","coke"],
            "url": "url_1"
        ] as AnyObject
]

let valid = JSONSerialization.isValidJSONObject(testObject) // true

print(testObject)