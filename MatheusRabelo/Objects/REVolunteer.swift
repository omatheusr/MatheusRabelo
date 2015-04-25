//
//  REVolunteer.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REVolunteer: NSObject {
    // MARK: - Static methods
    class func getVolunteer(dic : NSDictionary) -> REVolunteer
    {
        let vol : REVolunteer = REVolunteer()
        
        vol.descript = dic.objectForKey("description") as! String
        
        return vol
    }
    // MARK: - Vars
    var descript : String!
}
