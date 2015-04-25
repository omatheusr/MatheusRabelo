//
//  RELauncherViewController.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 18/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class RELauncherViewController: UIViewController {
    // MARK: - Vars
    
    @IBOutlet weak var centerCircleView: UIButton!
    @IBOutlet weak var topCircleView: UIView!
    @IBOutlet weak var leftCircleView: UIView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    var currentDefaultPallet : Int = 0
    
    var showResumeView : UIView!
    
    // MARK: - Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentDefaultPallet = REDefaults.pallet!
        
        self.centerCircleView.clipsToBounds = true
        self.centerCircleView.backgroundColor = REColor.colorBlue
        self.centerCircleView.alpha = 0.9
        self.centerCircleView.layer.cornerRadius = self.centerCircleView.frame.size.width / 2

        self.topCircleView.clipsToBounds = true
        self.topCircleView.alpha = 0.9
        self.topCircleView.backgroundColor = REColor.colorPurple
        self.topCircleView.layer.cornerRadius = self.topCircleView.frame.size.width / 2
        
        self.leftCircleView.clipsToBounds = true
        self.leftCircleView.alpha = 0.9
        self.leftCircleView.backgroundColor = REColor.colorGreen
        self.leftCircleView.layer.cornerRadius = self.leftCircleView.frame.size.width / 2
        
        self.imgPhoto.clipsToBounds = true
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.width / 2.0
        
        self.updateColorPallet(self.currentDefaultPallet)
        
        UIView.animateWithDuration(1.6, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
            self.centerCircleView.transform = CGAffineTransformMakeScale(0.95, 0.95)
            self.topCircleView.transform = CGAffineTransformMakeScale(0.95, 0.95)
            self.leftCircleView.transform = CGAffineTransformMakeScale(0.95, 0.95)
            self.imgPhoto.transform = CGAffineTransformMakeScale(0.95, 0.95)
            
        }, completion: nil)
        
        
        self.showResumeView = UIView(frame: self.view.frame)
        self.showResumeView.alpha = 1
        
        self.view.addSubview(self.showResumeView)
        let tapMyResume : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("openMyResume:"))
        self.showResumeView.addGestureRecognizer(tapMyResume)
    }
    
    // MARK: - Actions
    @IBAction func openMyResume(tap: UITapGestureRecognizer)
    {
        let centerCircleCopy : UIView = UIView()
        centerCircleCopy.backgroundColor = self.centerCircleView.backgroundColor
        centerCircleCopy.frame = CGRectMake(0, 0, 20, 20)
        centerCircleCopy.clipsToBounds = true
        centerCircleCopy.layer.cornerRadius = centerCircleCopy.frame.size.width / 2.0
        centerCircleCopy.center = tap.locationInView(self.showResumeView)
        
        self.view.addSubview(centerCircleCopy)
        
        UIView.animateWithDuration(0.8, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            centerCircleCopy.transform = CGAffineTransformMakeScale(150, 150)
            
        }) { (completed) -> Void in
            self.performSegueWithIdentifier("segueIntroToMain", sender: tap)
        }
    }
    
    // MARK: - Others
    func updateColorPallet(index: Int){
        if let pallet = REColor.getColorPallet(index)
        {
            self.centerCircleView.backgroundColor = pallet.objectAtIndex(0) as? UIColor
            self.topCircleView.backgroundColor = pallet.objectAtIndex(2) as? UIColor
            self.leftCircleView.backgroundColor = pallet.objectAtIndex(4) as? UIColor
        }else
        {
            let pallet = REColor.getFirstColorPallet()
            
            self.centerCircleView.backgroundColor = pallet.objectAtIndex(0) as? UIColor
            self.topCircleView.backgroundColor = pallet.objectAtIndex(2) as? UIColor
            self.leftCircleView.backgroundColor = pallet.objectAtIndex(4) as? UIColor
        }
    }
    
}
