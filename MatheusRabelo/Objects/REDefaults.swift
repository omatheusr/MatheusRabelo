//
//  REDefaults.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/21/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REDefaults: NSObject {
    // MARK: - Definitions
    private static let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    private class var CAMERAISAVAILABLE : String{
        return "CAMERAISAVAILABLE"
    }
    private class var SHOWCAMERA : String{
        return "SHOWCAMERA"
    }
    private class var SHOWFRONTCAMERA : String {
        return "SHOWFRONTCAMERA"
    }
    private class var PALLET : String{
        return "CURRENTPALLET"
    }
    
    // MARK: - Controll Functions
    
    class func initializeAppDefaultsConfig(){
        cameraIsAvailable = true
        
        if(showCamera == nil)
        {
            showCamera = true
        }
        if(showFrontCamera == nil)
        {
            showFrontCamera = false
        }
        if(pallet == nil)
        {
            pallet = 0
        }
    }
    
    // MARK: - NSDefault Controlls
    class var cameraIsAvailable : Bool?{
        get{
            return defaults.boolForKey(CAMERAISAVAILABLE)
        }
        set(value){
            defaults.setObject(value, forKey: CAMERAISAVAILABLE)
        }
    }
    class var showCamera: Bool?{
        get{
            if(cameraIsAvailable!)
            {
                return defaults.boolForKey(SHOWCAMERA)
            }else{
                return false
            }
        }
        set(value){
            if(cameraIsAvailable!)
            {
                defaults.setObject(value, forKey: SHOWCAMERA)
            }else{
                defaults.setObject(false, forKey: SHOWCAMERA)
            }
        }
    }
    class var showFrontCamera: Bool?{
        get{
            return defaults.boolForKey(SHOWFRONTCAMERA)
        }
        set(value){
            defaults.setObject(value, forKey: SHOWFRONTCAMERA)
        }
    }
    class var pallet: Int?{
        get{
            return defaults.integerForKey(PALLET)
        }
        set(value){
            defaults.setObject(value, forKey: PALLET)
        }
    }
    
}
