//
//  REResumeViewController.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit
import AVFoundation

class REResumeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Definitions
    let standardFont : String = "HelveticaNeue-Light"
    
    let cellIdentifierReusableLabel : String = "cell-reusable-label"
    let cellIdentifierProfile : String = "cell-profile"
    let cellIdentifierEducation : String = "cell-education"
    let cellIdentifierVolunteer : String = "cell-volunteer"
    let cellIdentifierExperience : String = "cell-experience"
    let cellIdentifierHeaderFooter : String = "cell-header-footer"
    let cellIdentifierSocial : String = "cell-social"
    let cellIdentifierInfo : String = "cell-info"
    let cellIdentifierProject : String = "cell-project"
    
    // MARK: - Section Colors
    
    var section1_Color : UIColor!
    var section3_Color : UIColor!
    var section4_Color : UIColor!
    var section5_Color : UIColor!
    var section6_Color : UIColor!
    var section7_Color : UIColor!
    
    // MARK: - Vars
    var numOfRowsAtEducationSection : Int!
    var numOfRowsAtVolunteerSection : Int!
    var numOfRowsAtExperienceSection : Int!
    var numOfRowsAtProjectSection : Int!
    
    var currentDefaultShowCamera : Bool = true
    var currentDefaultFrontCamera : Bool = false
    var currentDefaultPallet : Int = 0
    
    var infoPopUp : REDetailPopUpViewController?
    
    let formatterMonthYear = NSDateFormatter()
    
    
    // MARK: - Camera Vars
    var cameraSession : AVCaptureSession?
    
    var cameraBack : AVCaptureDevice?
    var cameraFront : AVCaptureDevice?
    var cameraView : UIView?
    
    var stillOutput : AVCaptureStillImageOutput!
    
    // MARK: - Outlets
    @IBOutlet weak var tableResume: UITableView!
    
    // MARK: - Events
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        REResume.loadDataFromResumePList()
        
        self.formatterMonthYear.locale = NSLocale.currentLocale()
        self.formatterMonthYear.dateFormat = "MMM yyyy"
        
        self.numOfRowsAtEducationSection = REResume.resume.education.count + 2
        self.numOfRowsAtVolunteerSection = REResume.resume.volunteer.count + 2
        self.numOfRowsAtExperienceSection = REResume.resume.experience.count + 2
        self.numOfRowsAtProjectSection = REResume.resume.project.count + 2
        
        self.currentDefaultShowCamera = REDefaults.showCamera!
        self.currentDefaultFrontCamera = REDefaults.showFrontCamera!
        self.currentDefaultPallet = REDefaults.pallet!
        
        self.tableResume.delegate = self
        self.tableResume.dataSource = self
        
        let tapChangColor : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("changeColor:"))
        self.tableResume.addGestureRecognizer(tapChangColor)
        
        self.makeLayout()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("defaultsChangedAction:"), name: NSUserDefaultsDidChangeNotification, object: nil)
    }
    
    // MARK: - DataSource + Delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        /*
        *   SECTIONS:
        *   - Basic Info
        *   - Description
        *   - Education
        *   - Volunteer
        *   - Experience
        *   - Projects
        *   - Contact
        */
        return 7
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows : Int = 0
        
        switch(section){
        case 0: // SECTION 1 - Basic Info
            numRows = 4
        case 1: // SECTION 2 - Description
            numRows = 3
        case 2: // SECTION 3 - Education
            numRows = self.numOfRowsAtEducationSection
        case 3: // SECTION 4 - Volunteer
            numRows = self.numOfRowsAtVolunteerSection
        case 4: // SECTION 5 - Experience
            numRows = self.numOfRowsAtExperienceSection
        case 5: // SECTION 6 - Project
            numRows = self.numOfRowsAtProjectSection
        case 6: // SECTION 7 - Contact
            numRows = 4
        default:
            numRows = 0
        }
        
        return numRows
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        var footerHeaderName : String = ""
        var footerHeaderTitle : String = ""
        var footerHeaderColor : UIColor = UIColor.whiteColor()
        
        switch(indexPath.section)
        {
        case 0: // SECTION 1 - Basic Info
            switch(indexPath.row)
            {
            case 0: // PROFILE IMAGE
                let profileCell : REProfilePhotoTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierProfile) as! REProfilePhotoTableViewCell
                
                profileCell.backgroundColor = self.section1_Color
                
                profileCell.imgProfile.backgroundColor = self.section4_Color
                profileCell.imgProfile.image = UIImage(named: "photo1")
                
                profileCell.setButtonAction({ () -> () in
                    self.performSegueWithIdentifier("segueConfig", sender: nil)
                }, image: "icon-config-single")
                
                cell = profileCell
            case 1: // FULL NAME
                let labelCell : REReusableLabelTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierReusableLabel) as! REReusableLabelTableViewCell
                
                labelCell.backgroundColor = self.section1_Color
                
                labelCell.animationIdentifier = "pop"
                labelCell.contentLabel.text = REResume.resume.name
                labelCell.contentLabel.font = UIFont(name: self.standardFont, size: 16)
                
                cell = labelCell
            case 2: // YEARS OLD
                let labelCell : REReusableLabelTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierReusableLabel) as! REReusableLabelTableViewCell
                
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate:REResume.resume.birthday, toDate: NSDate(), options: nil)
                
                labelCell.backgroundColor = self.section1_Color
                labelCell.contentLabel.text = String(format: "%d years old", components.year)
                labelCell.contentLabel.font = UIFont(name: self.standardFont, size: 14)
                
                cell = labelCell
            case 3: // FOOTER
                footerHeaderName = "footer1"
                footerHeaderColor = self.section1_Color
            default:
                cell = nil
            }
        case 1: // SECTION 2 - Description
            switch(indexPath.row)
            {
            case 0:
                let labelCell : REReusableLabelTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierReusableLabel) as! REReusableLabelTableViewCell
                
                if(REDefaults.showCamera!){
                    labelCell.backgroundColor = UIColor.clearColor()
                }else{
                    labelCell.backgroundColor = UIColor.whiteColor()
                }
                labelCell.contentLabel.text = REResume.resume.shortDescription
                labelCell.contentLabel.textColor = UIColor.blackColor()
                labelCell.contentLabel.font = UIFont(name: self.standardFont, size: 14)
                
                cell = labelCell
            case 1:
                let labelCell : REReusableLabelTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierReusableLabel) as! REReusableLabelTableViewCell
                
                if(REDefaults.showCamera!){
                    labelCell.backgroundColor = UIColor.clearColor()
                }else{
                    labelCell.backgroundColor = UIColor.whiteColor()
                }
                labelCell.contentLabel.text = REResume.resume.longDescription
                labelCell.contentLabel.textColor = UIColor.blackColor()
                labelCell.contentLabel.font = UIFont(name: self.standardFont, size: 14)
                
                cell = labelCell
            case 2:
                let labelCell : REReusableLabelTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierReusableLabel) as! REReusableLabelTableViewCell
                
                
                if(REDefaults.showCamera!){
                    labelCell.backgroundColor = UIColor.clearColor()
                }else{
                    labelCell.backgroundColor = UIColor.whiteColor()
                }
                labelCell.contentLabel.text = "Click here to know more about me"
                labelCell.contentLabel.textColor = self.section1_Color
                labelCell.contentLabel.font = UIFont(name: self.standardFont, size: 14)
                
                
                labelCell.makeClicable({ () -> () in
                    self.performSegueWithIdentifier("segueMoreInfo", sender: nil)
                })
                
                cell = labelCell
            default:
                cell = nil
            }
        case 2: // SECTION 3 - Education
            switch(indexPath.row)
            {
            case 0: // HEADER
                footerHeaderName = "header1"
                footerHeaderColor = self.section3_Color
                footerHeaderTitle = "Education"
            case (self.numOfRowsAtEducationSection - 1): // FOOTER
                footerHeaderName = "footer2"
                footerHeaderColor = self.section3_Color
            default:
                let cellEducation : REEducationCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierEducation) as! REEducationCellTableViewCell
                cellEducation.backgroundColor = self.section3_Color
                
                cellEducation.education = REResume.resume.education.objectAtIndex(indexPath.row - 1) as! REEducation
                
                cell = cellEducation
            }
        case 3: // SECTION 4 - Volunteer
            switch(indexPath.row)
            {
            case 0:
                footerHeaderName = "header1"
                footerHeaderColor = self.section4_Color
                footerHeaderTitle = "Volunteer"
            case (self.numOfRowsAtVolunteerSection - 1):
                footerHeaderName = "footer1"
                footerHeaderColor = self.section4_Color
            default:
                let cellVolunteer : REVolunteerCellTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifierVolunteer) as! REVolunteerCellTableViewCell
                cellVolunteer.backgroundColor = self.section4_Color
                
                cellVolunteer.volunteer = REResume.resume.volunteer.objectAtIndex(indexPath.row - 1) as! REVolunteer
                
                cell = cellVolunteer
            }
            
            
        case 4://SECTION 5 - Experience
            switch(indexPath.row)
            {
            case 0:
                footerHeaderName = "header2"
                footerHeaderColor = self.section5_Color
                footerHeaderTitle = "Experience"
            case (self.numOfRowsAtExperienceSection - 1):
                footerHeaderName = "footer1"
                footerHeaderColor = self.section5_Color
            default:
                let cellExperience : REExperienceCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierExperience) as! REExperienceCellTableViewCell
                cellExperience.backgroundColor = self.section5_Color
                
                
                cellExperience.experience = REResume.resume.experience.objectAtIndex(indexPath.row - 1) as! REExperience
                
                cellExperience.addInfoAction({ () -> () in
                    let storyB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    self.infoPopUp = storyB.instantiateViewControllerWithIdentifier("vcInfoPopUp") as? REDetailPopUpViewController
                    
                    if let popup = self.infoPopUp
                    {
                        popup.show(self.view)
                        popup.setText(cellExperience.experience.title, descript: cellExperience.experience.descript)
                    }
                })
                
                cell = cellExperience
            }
        case 5: // SECTION - Projects
            switch(indexPath.row)
            {
            case 0: // HEADER
                footerHeaderName = "header2"
                footerHeaderColor = self.section6_Color
                footerHeaderTitle = "Projects"
            case (self.numOfRowsAtProjectSection - 1):
                footerHeaderName = "footer2"
                footerHeaderColor = self.section6_Color
            default:
                let cellProject : REProjectCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierProject) as! REProjectCellTableViewCell
                cellProject.backgroundColor = self.section6_Color
                cellProject.project = REResume.resume.project.objectAtIndex(indexPath.row - 1) as! REProject
                
                cellProject.addInfoAction({ () -> () in
                    let storyB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    self.infoPopUp = storyB.instantiateViewControllerWithIdentifier("vcInfoPopUp") as? REDetailPopUpViewController
                    
                    if let popup = self.infoPopUp
                    {
                        popup.show(self.view)
                        popup.setText(cellProject.project.name, descript: cellProject.project.descript)
                        popup.setImageTop(UIImage(named: cellProject.project.imagedarkname))
                    }
                })
                
                
                cell = cellProject
            }
        case 6: // SECTION 7 - Contact
            switch(indexPath.row)
            {
            case 0:
                footerHeaderName = "header3"
                footerHeaderColor = self.section7_Color
                footerHeaderTitle = "Contact"
            case 1: // PHONE NUMBER
                let cellPhone : REInfoCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierInfo) as! REInfoCellTableViewCell
                cellPhone.backgroundColor = self.section7_Color
                
                cellPhone.lblTitle.text = "Phone"
                cellPhone.addInfoAction({ () -> () in
                    var phone = REResume.resume.phone
                    phone = phone.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    phone = phone.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    
                    let url : NSURL = NSURL(string: "tel:\(phone)")!
                    UIApplication.sharedApplication().openURL(url)
                })
                cellPhone.lblDescription.text = REResume.resume.phone
                
                cell = cellPhone
            case 2: // EMAIL
                let cellEmail : REInfoCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierInfo) as! REInfoCellTableViewCell
                cellEmail.backgroundColor = self.section7_Color
                
                cellEmail.lblTitle.text = "E-Mail"
                cellEmail.addInfoAction({ () -> () in
                    
                    let url : NSURL = NSURL(string: "mailto:\(REResume.resume.email)")!
                    UIApplication.sharedApplication().openURL(url)
                })
                cellEmail.lblDescription.text = REResume.resume.email
                
                cell = cellEmail
            case 3: // SOCIAL MEDIA
                let cellSocial : RESocialCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierSocial) as! RESocialCellTableViewCell
                cellSocial.backgroundColor = self.section7_Color
                
                cellSocial.facebookID = REResume.resume.facebookID
                cellSocial.linkedInID = REResume.resume.linkedinID
                
                cellSocial.facebookURL = REResume.resume.facebookURL
                cellSocial.linkedInURL = REResume.resume.linkedinURL
                
                cellSocial.github = REResume.resume.github
                
                cell = cellSocial
            default:
                cell = nil
            }
        default:
            cell = nil
        }
        
        if(cell == nil)
        {
            if(!footerHeaderName.isEmpty)
            {   // Generate HEADER || FOOTER
                let header : REHeaderFooterCellTableViewCell = self.tableResume.dequeueReusableCellWithIdentifier(self.cellIdentifierHeaderFooter) as! REHeaderFooterCellTableViewCell
                header.setImage(footerHeaderName, color: footerHeaderColor)
                
                if(REDefaults.showCamera!){
                    header.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
                }else{
                    header.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                }
                
                header.lblTitle.text = footerHeaderTitle
                
                cell = header
            }
        }
        
        if(cell != nil)
        {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height : CGFloat = 0
        
        let headerFooterHeight : CGFloat = 40
        switch(indexPath.section)
        {
        case 0:// SECTION 1 - Basic Info
            switch(indexPath.row)
            {
            case 0:
                height = 250
            default:
                height = headerFooterHeight
            }
        case 1:// SECTION 2 - Description
            height = 100
        case 2:// SECTION 3 - Education
            switch (indexPath.row)
            {
            case 0:
                fallthrough
            case (self.numOfRowsAtEducationSection - 1):
                height = headerFooterHeight
            default:
                height = 147
            }
        case 3:// SECTION 4 - Volunteer
            switch(indexPath.row)
            {
            case 0:
               fallthrough
            case (self.numOfRowsAtVolunteerSection - 1):
                height = headerFooterHeight
            default:
                height = 147
            }
        case 4://SECTION 5 - Experience
            switch(indexPath.row)
            {
            case 0:
                fallthrough
            case (self.numOfRowsAtExperienceSection - 1):
                height = headerFooterHeight
            default:
                height = 132
            }
        case 5: // SECTION 6 - Project
            switch(indexPath.row)
            {
            case 0:
                fallthrough
            case (self.numOfRowsAtProjectSection - 1):
                height = headerFooterHeight
            default:
                height = 140
            }
        case 6: // SECTION 7 - Contact
            switch(indexPath.row)
            {
            case 1:
                fallthrough
            case 2:
                height = 57
            case 3:
                height = 94
            default:
                height = headerFooterHeight
            }
        default:
            height = 0
        }
        
        return height
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let profileCell : REProfilePhotoTableViewCell = cell as? REProfilePhotoTableViewCell
        {
            profileCell.cellWillAppearAnimation()
        }else if let reusableLabelCell : REReusableLabelTableViewCell = cell as? REReusableLabelTableViewCell
        {
            reusableLabelCell.cellWillAppearAnimation()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(!REDefaults.showCamera!){
            if(scrollView.contentOffset.y <= 10)
            {
                self.tableResume.backgroundColor = self.section1_Color
            }else{
                self.tableResume.backgroundColor = self.section7_Color
            }
        }
    }
    
    // MARK: - Other Functions
    func makeLayout(){
        if(self.currentDefaultShowCamera)
        {
            self.initializeCamera()
        }
        
        self.tableResume.backgroundColor = REColor.colorWhite
        self.tableResume.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableResume.separatorColor = UIColor.clearColor()
        self.tableResume.backgroundView = UIView()
        
        self.updateColorPallet(REDefaults.pallet!)
        
    }
    func stopCamera()
    {
        REColor.alpha = 1
        if(self.cameraSession != nil && self.cameraSession!.running)
        {
            self.cameraSession!.stopRunning()
        }
        if(self.cameraView != nil)
        {
            self.cameraView!.removeFromSuperview()
        }
    }
    func initializeCamera(){
        self.stopCamera()
        
        self.tableResume.backgroundColor = REColor.colorWhite
        
        self.cameraView = UIView()
        self.cameraView!.frame = self.view.frame
            
        self.view.addSubview(self.cameraView!)
        self.view.sendSubviewToBack(self.cameraView!)
        
        
        self.cameraSession = AVCaptureSession()
        self.cameraSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let videoPreviewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.cameraSession!)
        
        videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer.frame = self.cameraView!.frame
        
        self.cameraView!.layer.addSublayer(videoPreviewLayer)
        
        let layer : CALayer = self.cameraView!.layer
        layer.masksToBounds = true
        
        if(self.cameraBack == nil || self.cameraFront == nil)
        {
            for device in AVCaptureDevice.devices()
            {
                if(device.hasMediaType(AVMediaTypeVideo))
                {
                    if(device.position == AVCaptureDevicePosition.Back)
                    {
                        self.cameraBack = device as? AVCaptureDevice
                    }else if(device.position == AVCaptureDevicePosition.Front)
                    {
                        self.cameraFront = device as? AVCaptureDevice
                    }
                }
            }
        }
        
        var input : AVCaptureDeviceInput!
        if(REDefaults.showFrontCamera! && self.cameraFront != nil){
            input = AVCaptureDeviceInput(device: self.cameraFront!, error: nil)
        }else if(self.cameraBack != nil)
        {
            input = AVCaptureDeviceInput(device: self.cameraBack!, error: nil)
        }
        
        if(input == nil)
        {
            REDefaults.cameraIsAvailable = false
            //REDefaults.showCamera = false
            REColor.alpha = 1
        }else{
            REColor.alpha = 0.9
            REDefaults.cameraIsAvailable = true
            //REDefaults.showCamera = true
            
            self.cameraSession!.addInput(input)
            let outputSettings : NSDictionary = NSDictionary(objectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey)
            
            self.stillOutput = AVCaptureStillImageOutput()
            self.stillOutput.outputSettings = outputSettings as [NSObject : AnyObject]
        
            self.cameraSession!.addOutput(self.stillOutput)
            self.cameraSession!.startRunning()
        }
    }
    func updateColorPallet(index: Int){
        if let pallet = REColor.getColorPallet(index)
        {
            self.section1_Color = pallet.objectAtIndex(0) as! UIColor
            self.section3_Color = pallet.objectAtIndex(1) as! UIColor
            self.section4_Color = pallet.objectAtIndex(2) as! UIColor
            self.section5_Color = pallet.objectAtIndex(3) as! UIColor
            self.section6_Color = pallet.objectAtIndex(4) as! UIColor
            self.section7_Color = pallet.objectAtIndex(5) as! UIColor
        }else
        {
            let pallet = REColor.getFirstColorPallet()
            
            self.section1_Color = pallet.objectAtIndex(0) as! UIColor
            self.section3_Color = pallet.objectAtIndex(1) as! UIColor
            self.section4_Color = pallet.objectAtIndex(2) as! UIColor
            self.section5_Color = pallet.objectAtIndex(3) as! UIColor
            self.section6_Color = pallet.objectAtIndex(4) as! UIColor
            self.section7_Color = pallet.objectAtIndex(5) as! UIColor
        }
        self.tableResume.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func changeColor (tap : UITapGestureRecognizer){
        
        if let palletIndex = REDefaults.pallet
        {
            let nextIndex = REColor.nextPalletColorIndex(palletIndex)
            REDefaults.pallet = nextIndex
            
            self.updateColorPallet(nextIndex)
        }
    }
    @IBAction func defaultsChangedAction (notification: NSNotification){
        if let palletIndex = REDefaults.pallet
        {
            if(palletIndex != self.currentDefaultPallet)
            {
                self.updateColorPallet(palletIndex)
                self.currentDefaultPallet = palletIndex
            }
        }
        
        if let showCamera = REDefaults.showCamera
        {
            if(showCamera != self.currentDefaultShowCamera)
            {
                self.currentDefaultShowCamera = showCamera
                if(!showCamera)
                {
                    self.stopCamera()
                }else{
                    self.initializeCamera()
                }
                self.updateColorPallet(self.currentDefaultPallet)
                self.tableResume.reloadData()
            }
        }
        
        if let showFrontCamera = REDefaults.showFrontCamera
        {
            if(showFrontCamera != self.currentDefaultFrontCamera)
            {
                self.currentDefaultFrontCamera = showFrontCamera
                self.initializeCamera()
            }
        }
    }
    @IBAction func backFromMoreInfo (segue: UIStoryboardSegue){
        
    }
}
