//
//  REEducation.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REEducation: NSObject {
    
    // MARK: - Static methods
    
    class func getEducation(dic : NSDictionary) -> REEducation {
        var edu : REEducation = REEducation()
        
        edu.courseName = dic.objectForKey("courseName") as! String
        edu.institutionName = dic.objectForKey("institution") as! String
        edu.institutionShort = dic.objectForKey("institutionShort") as! String
        
        edu.startDate = dic.objectForKey("startDate") as! NSDate
        edu.endDate = dic.objectForKey("endDate") as! NSDate
        
        return edu
    }
    
    // MARK: - Vars
    var courseName : String!
    
    var institutionName : String!
    var institutionShort : String!
    
    var startDate : NSDate!
    var endDate : NSDate!
    
    // MARK: - Controll Functions
    func getStartEndDate() -> String{
        let formatterMonthYear = NSDateFormatter()
        formatterMonthYear.locale = NSLocale.currentLocale()
        formatterMonthYear.dateFormat = "MMM yyyy"
        
        var startDate : String = formatterMonthYear.stringFromDate(self.startDate).capitalizedString
        var endDate : String!
        if(self.endDate.timeIntervalSinceDate(NSDate()) > 0)
        {
            endDate = "Present"
        }else{
            endDate = formatterMonthYear.stringFromDate(self.endDate).capitalizedString
        }
        
        return startDate.stringByAppendingString(" - ".stringByAppendingString(endDate))
    }
    
    
}
