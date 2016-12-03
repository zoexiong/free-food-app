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



//let testObject:[String:AnyObject] = ([
//    "event_name":"Zillow Info Session",
//    "location": "MGH 142",
//    "zip_code": "98105",
//    "date":"11/16/2016",
//    "start_time": "12:30",
//    "end_time": "13:30",
//    "foods": ["pizza","coke"],
//    "url": "url_1"
//    ]as AnyObject) as! [String : AnyObject]

let testObject:AnyObject = [
    "event_name":"Zillow Info Session",
    "location": "MGH 142",
    "zip_code": "98105",
    "date":"11/16/2016",
    "start_time": "12:30",
    "end_time": "13:30",
    "foods": ["pizza","coke"],
    "description":"event description",
    "url": "url_1"
    ] as AnyObject

let valid = JSONSerialization.isValidJSONObject(testObject) // true

print(testObject)
//print(testObject.event_0)

//var eventListLink = "https://raw.githubusercontent.com/zoexiong/free-food/Z_branch/FreeFood/events.json"
//
//
//public func getEventFromJson(){
//    let requestURL: NSURL = NSURL(string: eventListLink)!
//    let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
//    let session = URLSession.shared
//    let task = session.dataTask(with: urlRequest as URLRequest) {
//        (data, response, error) -> Void in
//        let httpResponse = response as! HTTPURLResponse
//        let statusCode = httpResponse.statusCode
//        if (statusCode == 200) {
//            print("downloaded successfully.")
//            do{
//                let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
//                if let jsonEvents = json as? [String:AnyObject]{
//                    print("below is the json keys")
//                    for (key,value) in jsonEvents{
//                        print(key)
//                    }
//                }
//            }catch {
//                print("Error with Json: \(error)")
//            }
//            
//        }
//    }
//    task.resume()
//}
