//
//  REProjects.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/25/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REProject: NSObject {
    
    // MARK: - Static methods
    class func getProject(dic : NSDictionary) -> REProject {
        var proj : REProject = REProject()
        
        proj.name = dic.objectForKey("title") as! String
        proj.descript = dic.objectForKey("description") as! String
        proj.imagename = dic.objectForKey("image") as! String
        proj.imagedarkname = dic.objectForKey("imageDark") as! String
        
        return proj
    }
    
    // MARK: - Vars
    var name : String!
    var descript : String!
    var imagename : String!
    var imagedarkname : String!
}
