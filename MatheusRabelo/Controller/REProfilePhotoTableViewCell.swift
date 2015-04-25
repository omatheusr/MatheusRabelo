//
//  REProfilePhotoTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REProfilePhotoTableViewCell: RETableViewCell {

    // MARK: - Vars
    private var btnAction : (() -> ())?
    private var tapView : UIView!
    
    // MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var cellButton: UIButton!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 250
        self.cellButton.hidden = true
        
        self.imgProfile.layer.masksToBounds = true
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2
        self.imgProfile.layer.borderColor = UIColor.whiteColor().CGColor
        self.imgProfile.layer.borderWidth = 3
        self.imgProfile.userInteractionEnabled = true
        
    }
    
    // MARK: - Other functions
    func cellWillAppearAnimation(){
        self.imgProfile.transform = CGAffineTransformMakeScale(1, 1)
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: { () -> Void in
            self.imgProfile.transform = CGAffineTransformMakeScale(1.1, 1.1)
        }, completion: nil)
    }
    
    func setButtonAction(action: () -> (), image: String)
    {
        self.btnAction = action
        self.cellButton.setImage(UIImage(named: image), forState: UIControlState.Normal)
        self.cellButton.hidden = false
    }
    
    // MARK: - Actions
    @IBAction func cellButtonAction(sender: UIButton) {
        if(self.btnAction != nil)
        {
            self.btnAction!()
        }
    }
}
