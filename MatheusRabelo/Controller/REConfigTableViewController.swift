//
//  REConfigTableViewController.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/22/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REConfigTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var cellPallet1: UITableViewCell!
    @IBOutlet weak var cellPallet2: UITableViewCell!
    @IBOutlet weak var cellPallet3: UITableViewCell!
    @IBOutlet weak var cellPallet4: UITableViewCell!
    @IBOutlet weak var cellPallet5: UITableViewCell!
    @IBOutlet weak var cellPallet6: UITableViewCell!
    
    @IBOutlet weak var swtShowCamera: UISwitch!
    @IBOutlet weak var swtFrontCamera: UISwitch!
    
    // MARK: - Vars
    
    var currentPallet : Int = 0
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pallet = REDefaults.pallet
        {
            self.currentPallet = pallet
        }else{
            REDefaults.pallet = 0
            self.currentPallet = 0
        }
        
        if let camera = REDefaults.showCamera
        {
            self.swtShowCamera.setOn(camera, animated: false)
        }else{
            self.swtShowCamera.setOn(false, animated: false)
        }
        
        if let front = REDefaults.showFrontCamera
        {
            self.swtFrontCamera.setOn(front, animated: false)
        }else{
            self.swtFrontCamera.setOn(false, animated: false)
        }
        self.tableView.tableFooterView = UIView(frame:CGRectZero);
        self.navigationController!.navigationBar.tintColor = REColor.colorDarkBlue
        
        self.makePalletSelection(self.currentPallet)
    }
    
    // MARK: - DataSource + Delegates
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(indexPath.section == 1){
            REDefaults.pallet = indexPath.row
            self.currentPallet = indexPath.row
            self.makePalletSelection(self.currentPallet)
        }
        
    }
    
    // MARK: - Actions
    @IBAction func showCameraChanged(sender: UISwitch) {
        REDefaults.showCamera = sender.on
    }
    
    @IBAction func frontCameraChanged(sender: UISwitch) {
        REDefaults.showFrontCamera = sender.on
    }
    
    // MARK: - Other functions
    func makePalletSelection(pallet: Int){
        self.cellPallet1.backgroundColor = UIColor.whiteColor()
        self.cellPallet2.backgroundColor = UIColor.whiteColor()
        self.cellPallet3.backgroundColor = UIColor.whiteColor()
        self.cellPallet4.backgroundColor = UIColor.whiteColor()
        self.cellPallet5.backgroundColor = UIColor.whiteColor()
        self.cellPallet6.backgroundColor = UIColor.whiteColor()
        
        switch(pallet)
        {
        case 0:
            self.cellPallet1.backgroundColor = UIColor.lightGrayColor()
        case 1:
            self.cellPallet2.backgroundColor = UIColor.lightGrayColor()
        case 2:
            self.cellPallet3.backgroundColor = UIColor.lightGrayColor()
        case 3:
            self.cellPallet4.backgroundColor = UIColor.lightGrayColor()
        case 4:
            self.cellPallet5.backgroundColor = UIColor.lightGrayColor()
        case 5:
            self.cellPallet6.backgroundColor = UIColor.lightGrayColor()
            
        default:
            break
        }
    }

}
