//
//  REConfigInterfaceController.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/21/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import WatchKit
import Foundation

class REConfigInterfaceController: WKInterfaceController {
    
    var palletIndex : Int = 0
    
    @IBOutlet weak var swtCamera: WKInterfaceSwitch!
    @IBOutlet weak var swtCameraSide: WKInterfaceSwitch!
    
    @IBOutlet weak var btPalletColor: WKInterfaceButton!
    
    // Events
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.updateCurrentPallet()
    }
    // Actions
    @IBAction func switchCameraConfiguration(value: Bool) {
        self.swtCameraSide.setHidden(!value)
        WKInterfaceController.openParentApplication(["set":["SHOWCAMERA":value]], reply: { (obj, error) -> Void in })
    }
    @IBAction func switchCameraSide(value: Bool) {
        if(value)
        {
            self.swtCameraSide.setTitle("Front")
        }else{
            self.swtCameraSide.setTitle("Back")
        }
        WKInterfaceController.openParentApplication(["set":["SHOWFRONTCAMERA":value]], reply: { (obj, error) -> Void in })
        
    }
    @IBAction func btChangePalletColor() {
        self.setNextPallet()
    }
    
    
    
    // Others
    func setNextPallet(){
        WKInterfaceController.openParentApplication(["get":"CURRENTPALLET"], reply: { (obj, error) -> Void in
            
            if let response = obj as? [String : AnyObject]
            {
                if let index = response["CURRENTPALLET"] as? Int
                {
                    self.palletIndex = index
                }else
                {
                    self.palletIndex = -1
                }
            }
            
            
            var nextPalletIndex : Int = self.palletIndex+1
            if(nextPalletIndex > 5)
            {
                nextPalletIndex = 0
            }
            WKInterfaceController.openParentApplication(["set":["CURRENTPALLET":nextPalletIndex]], reply: { (obj, error) -> Void in
                
                if let response = obj as? [String : AnyObject]
                {
                    let resp = response["set"] as! String
                    self.palletIndex = nextPalletIndex
                    self.btPalletColor.setBackgroundImageNamed("Group\(self.palletIndex+1)")
                }
            })
        })
    }
    func updateCurrentPallet(){
        WKInterfaceController.openParentApplication(["get":"CURRENTPALLET"], reply: { (obj, error) -> Void in
            
            if let response = obj as? [String : AnyObject]
            {
                if let index = response["CURRENTPALLET"] as? Int
                {
                    self.palletIndex = index
                    self.btPalletColor.setBackgroundImageNamed("Group\(self.palletIndex+1)")
                }else{
                    self.setNextPallet()
                }
            }
        })
    }
}
