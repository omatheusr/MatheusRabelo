//
//  REAboutMeTableViewController.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/23/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REAboutMeTableViewController: UITableViewController {
    // MARK: - Vars
    var aboutMeRows : NSArray!
    
    // MARK: - Outlets
    @IBOutlet var tableAboutMe: UITableView!
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()

        let plistResume : String = NSBundle.mainBundle().pathForResource("aboutme", ofType: "plist")!
        let aboutMeData = NSDictionary(contentsOfFile: plistResume)!
        self.aboutMeRows = aboutMeData.objectForKey("rows") as! NSArray
        
        self.tableView.separatorColor = UIColor.clearColor()
        
        self.navigationController!.navigationBar.tintColor = REColor.colorDarkBlue
    }

    // MARK: - Data Source + Delegates
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aboutMeRows.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        if let dict = aboutMeRows.objectAtIndex(indexPath.row) as? NSDictionary
        {
            if let imagename = dict.objectForKey("image") as? String
            {
                let cellImage = tableView.dequeueReusableCellWithIdentifier("cell-image") as! RECellImageTableViewCell
            
                cellImage.img.image = UIImage(named: imagename)
                if let text = dict.objectForKey("text") as? String
                {
                    cellImage.lblText.text = text
                }
                cell = cellImage
            }
        }else if let text = aboutMeRows.objectAtIndex(indexPath.row) as? String
        {
            let cellSimpleRow : RECellSimpleRowTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell-row") as! RECellSimpleRowTableViewCell
            cellSimpleRow.contentLabel.text = text
            
            cell = cellSimpleRow
        }
        
        if (cell == nil){
            let cellSimpleRow : RECellSimpleRowTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell-row") as! RECellSimpleRowTableViewCell
            cellSimpleRow.contentLabel.text = ""
            
            cell = cellSimpleRow
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height : CGFloat = 114
        switch(indexPath.row)
        {
        case 0:
            height = 250
        case 5:
            fallthrough
        case 12:
            height = 20
        default:
            break
        }
        
        return height
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cellSimpleRow = cell as? RECellSimpleRowTableViewCell
        {
            cellSimpleRow.cellWillAppear()
        }else if let cellImage = cell as? RECellImageTableViewCell
        {
            cellImage.cellWillAppear()
        }
    }
}
