//
//  RECellRoundImageTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/24/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class RECellImageTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
    }
    func cellWillAppear(){
        self.lblText.alpha = 0
        self.img.alpha = 0
        
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.lblText.alpha = 1
            self.img.alpha = 1
            }, completion: nil)
    }
}
