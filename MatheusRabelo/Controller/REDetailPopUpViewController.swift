//
//  REDetailPopUpViewController.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/25/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REDetailPopUpViewController: UIViewController {
    
    //MARK: - Vars
    private let constraintConstantMin : CGFloat = 28
    private let constraintConstantMax : CGFloat = 236
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btClose: UIButton!
    
    @IBOutlet weak var constraintTitleToDescription: NSLayoutConstraint!
    
    
    //MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblDescription.textColor = UIColor.darkGrayColor()
        self.topImg.layer.masksToBounds = true
        self.setImageTop(nil)
        
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 15
        
        self.btClose.tintColor = REColor.colorDarkBlue
    }
    
    
    //MARK: - Other Functions
    func setImageTop(image: UIImage?)
    {   // Don't call it when showing view
        if(image == nil)
        {
            self.topImg.hidden = true
            self.constraintTitleToDescription.constant = self.constraintConstantMin
            self.view.layoutIfNeeded()
            self.lblTitle.textColor = UIColor.darkGrayColor()
        }else{
            self.topImg.hidden = false
            self.topImg.image = image!
            self.constraintTitleToDescription.constant = self.constraintConstantMax
            self.view.layoutIfNeeded()
            self.lblTitle.textColor = UIColor.whiteColor()
        }
    }
    
    func show(superview: UIView){
        self.view.frame = superview.frame
        self.view.alpha = 0
        self.mainView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        superview.addSubview(self.view)
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.view.alpha = 1
            self.mainView.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
    }
    func close(){
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.mainView.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }) { (completed) -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.mainView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    self.view.alpha = 0
                    }) { (completed) -> Void in
                        self.view.removeFromSuperview()
                }
        }
    }
    func setText(title: String, descript: String){
        self.lblTitle.text = title
        self.lblDescription.text = descript
        
    }
    //MARK: - Actions
    @IBAction func btCloseTouchUpInsideAction(sender: UIButton) {
        self.close()
    }
}
