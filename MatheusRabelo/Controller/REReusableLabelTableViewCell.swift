//
//  REReusableLabelTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REReusableLabelTableViewCell: RETableViewCell {

    // MARK: - Vars
    private var clicableAction : (() -> ())?
    var animationIdentifier : String?
    
    // MARK: - Outlets
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 40
    }
    
    // MARK: - Other functions
    func makeClicable(action: ()->())
    {
        self.clicableAction = action
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("executeClosure:"))
        self.addGestureRecognizer(tap)
    }
    func cellWillAppearAnimation(){
        if(self.animationIdentifier == nil)
        {
            self.contentLabel.alpha = 0
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.contentLabel.alpha = 1
            })
        }else{
            if(self.animationIdentifier == "pop")
            {
                self.contentLabel.alpha = 0
                self.contentLabel.transform = CGAffineTransformMakeScale(0.5, 0.5)
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.contentLabel.alpha = 1
                    self.contentLabel.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    }, completion: { (completed)-> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.contentLabel.transform = CGAffineTransformMakeScale(1, 1)
                        })
                })
            }
        }
    }
    
    // MARK: - Outlets
    @IBAction func executeClosure(tap: UITapGestureRecognizer){
        if(self.clicableAction != nil)
        {
            self.clicableAction!()
        }
    }
    
}
