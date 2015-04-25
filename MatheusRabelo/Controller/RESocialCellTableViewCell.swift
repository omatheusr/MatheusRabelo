//
//  RESocialCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 19/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class RESocialCellTableViewCell: RETableViewCell {

    //MARK: - Vars
    var facebookID : String!
    var facebookURL : String!
    
    var linkedInID : String!
    var linkedInURL : String!
    
    var github : String!
    
    //MARK: - Outlets
    @IBOutlet weak var btGitHub: UIButton!
    @IBOutlet weak var btFacebook: UIButton!
    @IBOutlet weak var btLinkedIn: UIButton!

    //MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 94
    }
    
    
    //MARK: - Actions
    @IBAction func btGitHubTouchUpInsideAction(sender: UIButton)
    {
        if(self.github != nil){
            let url : NSURL = NSURL(string: "http://github.com/\(self.github)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func btFacebookTouchUpInsideAction(sender: UIButton)
    {
        var done : Bool = false
        
        if(self.facebookID != nil){
            let url : NSURL = NSURL(string: "fb://profile/\(self.facebookID)")!
            if(UIApplication.sharedApplication().openURL(url))
            {
                done = true
            }
        }
        
        if(self.facebookURL != nil && !done)
        {
            let url : NSURL = NSURL(string: "http://facebook.com/\(self.facebookURL)")!
            if(UIApplication.sharedApplication().openURL(url))
            {
                done = true
            }
        }
        if(!done)
        {
            println("couldn't open either: safari or facebook")
        }
    }
    
    @IBAction func btLinkedInTouchUpInsideAction(sender: UIButton)
    {
        var done : Bool = false
        if(self.linkedInID != nil)
        {
            let url : NSURL = NSURL(string: "linkedin://#profile/\(self.linkedInID)")!
            if(UIApplication.sharedApplication().openURL(url))
            {
                done = true
            }
        }
        
        if(self.linkedInURL != nil && !done)
        {
            let url : NSURL = NSURL(string: "http://linkedin.com/in/\(self.linkedInURL)")!
            if(UIApplication.sharedApplication().openURL(url))
            {
                done = true
            }
        }
        
        if(!done)
        {
            println("couldn't open either: safari or linkedin")
        }
    }
    
}
