//
//  SpotObj.swift
//  Uploading
//
//  Created by 柯東爵 on 2018/6/3.
//  Copyright © 2018年 CSIE. All rights reserved.
//


import Foundation

struct SpotObj {
    var Name: String
    var Address: String
    var Description: String
    var ImageURL: String
    var OpeningHours: String
    var TravellingInformation: String
    static func loadSpotData(arr: NSArray) -> [SpotObj] {
        var SpotArr: [SpotObj] = []
        for element in arr {
            if let dict = element as? NSDictionary {
                let _name  = dict.value(forKey: "name") as! String
                let _address = dict.value(forKey: "address") as! String
                let _description = dict.value(forKey: "description") as! String
                let _openingHours = dict.value(forKey: "openingHours") as! String
                let _travellingInformation = dict.value(forKey: "travellingInformation") as! String
                let _imageurl = dict.value(forKey: "image") as! String
                SpotArr.append(SpotObj(Name: _name, Address: _address, Description: _description, ImageURL: _imageurl, OpeningHours: _openingHours, TravellingInformation: _travellingInformation))
            }
        }
        for i in SpotArr {
            print(i.Name)
        }
        return SpotArr
    }
}
