//
//  RECellSimpleRowTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/23/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class RECellSimpleRowTableViewCell: RETableViewCell {

    // MARK: - Vars
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        
        super.height = 114
    }
    func cellWillAppear(){
        self.contentLabel.alpha = 0
        
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.contentLabel.alpha = 1
        }, completion: nil)
    }
}
