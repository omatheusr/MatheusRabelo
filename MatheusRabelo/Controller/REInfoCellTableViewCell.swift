//
//  REInfoCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 18/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REInfoCellTableViewCell: RETableViewCell {
    
    //MARK: - Vars
    private var infoAction: (()->())?
    
    //MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 57
    }
    //MARK: - Other Functions
    func addInfoAction(action: ()->())
    {
        self.infoAction = action
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("infoAction:"))
        self.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    @IBAction func infoAction(tap : UITapGestureRecognizer)
    {
        if(self.infoAction != nil)
        {
            self.infoAction!()
        }
    }
}
