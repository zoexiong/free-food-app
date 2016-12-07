//: Playground - noun: a place where people can play

import UIKit







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


