//
//  REResume.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

private let theresume = REResume()

class REResume: NSObject {
    // MARK: - Static methods
    class var resume : REResume
    {
        return theresume
    }
    
    class func loadDataFromResumePList()
    {
        let plistResume : String = NSBundle.mainBundle().pathForResource("resume", ofType: "plist")!
        REResume.resume.loadResumeData(NSMutableDictionary(contentsOfFile: plistResume)!)
    }
    
    // MARK - Vars
    var profileimage : NSData!
    
    var name : String!
    var birthday : NSDate!
    var phone : String!
    var email : String!
    
    var shortDescription : String!
    var longDescription : String!
    
    var education : NSMutableArray!
    var volunteer : NSMutableArray!
    var experience : NSMutableArray!
    var project : NSMutableArray!
    
    var facebookID : String!
    var facebookURL : String!
    
    var linkedinID : String!
    var linkedinURL : String!
    
    var github : String!
    
    // MARK: - Controll functions
    func addEducation(education : REEducation)
    {
        if(self.education == nil)
        {
            self.education = NSMutableArray()
        }
        self.education.addObject(education)
    }
    func addVolunteer(volunteer : REVolunteer)
    {
        if(self.volunteer == nil)
        {
            self.volunteer = NSMutableArray()
        }
        self.volunteer.addObject(volunteer)
    }
    func addExperience(experience : REExperience)
    {
        if(self.experience == nil)
        {
            self.experience = NSMutableArray()
        }
        self.experience.addObject(experience)
    }
    func addProject(project: REProject)
    {
        if(self.project == nil)
        {
            self.project = NSMutableArray()
        }
        self.project.addObject(project)
    }
    func loadResumeData(resumeFileData: NSDictionary)
    {
        self.name = resumeFileData.objectForKey("name") as! String
        self.birthday = resumeFileData.objectForKey("birthday") as! NSDate
        self.email = resumeFileData.objectForKey("email") as! String
        self.phone = resumeFileData.objectForKey("phone") as! String
        
        self.shortDescription = resumeFileData.objectForKey("shortDescription") as! String
        self.longDescription = resumeFileData.objectForKey("longDescription") as! String
        
        self.facebookID = resumeFileData.objectForKey("facebookId") as! String
        self.facebookURL = resumeFileData.objectForKey("facebookURL") as! String
        
        
        self.linkedinID = resumeFileData.objectForKey("linkedinId") as! String
        self.linkedinURL = resumeFileData.objectForKey("linkedinURL") as! String
        
        self.github = resumeFileData.objectForKey("github") as! String
        
        // LOAD EXPERIENCES
        let experiences : NSArray = resumeFileData.objectForKey("experience") as! NSArray
        self.experience = NSMutableArray()
        for exp in experiences
        {
            self.experience.addObject(REExperience.getExperience(exp as! NSDictionary))
        }
        
        // LOAD VOLUNTEERS
        let volunteers : NSArray = resumeFileData.objectForKey("volunteer") as! NSArray
        self.volunteer = NSMutableArray()
        for vol in volunteers
        {
            self.volunteer.addObject(REVolunteer.getVolunteer(vol as! NSDictionary))
        }
        
        // LOAD EDUCATION
        let educations : NSArray = resumeFileData.objectForKey("education") as! NSArray
        self.education = NSMutableArray()
        for edu in educations
        {
            self.education.addObject(REEducation.getEducation(edu as! NSDictionary))
        }
        
        // LOAD PROJECT
        let projects : NSArray = resumeFileData.objectForKey("project") as! NSArray
        self.project = NSMutableArray()
        for proj in projects
        {
            self.project.addObject(REProject.getProject(proj as! NSDictionary))
        }
    }
}
