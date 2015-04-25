//
//  REColor.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 18/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REColor: NSObject {
    static var alpha : CGFloat = 1
    
    // MARK: - Color Pallet
    private class var colorPallet : NSArray {
        return [
                    [colorBlue, colorGreen, colorOrange, colorPurple, colorBlue, colorRed],         // Pallet 1
                    [colorRed, colorOrange, colorGreen, colorBlue, colorLightGreen, colorPurple],   // Pallet 2
                    [colorLightGreen, colorPink, colorLightOrange, colorLightBlue, colorGreen, colorDarkBlue],// Pallet 3
                    [colorDarkBlue, colorLightOrange, colorPurple, colorOrange, colorLightOrange, colorBlue],// Pallet 4
                    [colorGreen, colorRed, colorLightGreen,  colorLightOrange, colorDarkBlue, colorPink],// Pallet 5
                    [colorLightOrange, colorBlue, colorRed, colorPink, colorLightGreen, colorGreen]// Pallet 6
                ]
    }
    class func getColorPallet(index: Int) -> NSArray?{
        if(index < 0 || index > colorPallet.count - 1)
        {
            return nil
        }else
        {
            return colorPallet[index] as? NSArray
        }
    }
    class func getFirstColorPallet() -> NSArray{
        return colorPallet[0] as! NSArray
    }
    class func nextPalletColorIndex(currentIndex : Int) -> Int{
        if(currentIndex > 4)
        {
            return 0
        }else{
            return currentIndex + 1
        }
    }
    
    // MARK: - APP Colors
    class var colorRed : UIColor{
        return UIColor(red: color(192), green: color(24), blue: color(63), alpha: alpha)
    }
    class var colorGreen :UIColor{
        return UIColor(red: color(139), green: color(174), blue: color(63), alpha: alpha)
    }
    class var colorBlue :UIColor{
        return UIColor(red: color(36), green: color(108), blue: color(220), alpha: alpha)
    }
    class var colorOrange :UIColor{
        return UIColor(red: color(235), green: color(124), blue: color(0), alpha: alpha)
    }
    class var colorPurple :UIColor{
        return UIColor(red: color(122), green: color(33), blue: color(223), alpha: alpha)
    }
    class var colorWhite : UIColor{
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
    }
    
    class var colorDarkBlue : UIColor{
        return UIColor(red: color(14), green: color(4), blue: color(86), alpha: alpha)
    }
    class var colorLightBlue : UIColor{
        return UIColor(red: color(42), green: color(120), blue: color(255), alpha: alpha)
    }
    class var colorLightOrange : UIColor{
        return UIColor(red: color(232), green: color(168), blue: color(75), alpha: alpha)
    }
    class var colorPink : UIColor{
        return UIColor(red: color(184), green: color(12), blue: color(208), alpha: alpha)
    }
    class var colorLightGreen : UIColor{
        return UIColor(red: color(23), green: color(172), blue: color(163), alpha: alpha)
    }
    
    
    
    private class func color(RGB : CGFloat) -> CGFloat
    {
        return RGB / 255.0
    }
    
    
}
