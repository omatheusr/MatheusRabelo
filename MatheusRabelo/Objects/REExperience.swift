//
//  REExperience.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REExperience: NSObject {
    // MARK: - Static methods
    class func getExperience(dic: NSDictionary) -> REExperience{
        let exp : REExperience = REExperience()
        
        exp.title = dic.objectForKey("title") as! String
        exp.local = dic.objectForKey("where") as! String
        exp.descript = dic.objectForKey("description") as! String
        
        exp.startDate = dic.objectForKey("startDate") as! NSDate
        exp.endDate = dic.objectForKey("endDate") as! NSDate
        
        return exp
    }
    
    // MARK: - Vars
    var title : String!
    var local : String!
    var descript : String!
    
    var startDate : NSDate!
    var endDate : NSDate!
    
    // MARK: - Controll Methods
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
