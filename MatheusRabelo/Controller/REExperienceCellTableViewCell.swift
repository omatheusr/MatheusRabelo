//
//  REExperienceCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 18/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REExperienceCellTableViewCell: RETableViewCell {
    // MARK: - Vars
    private var infoAction : (()->())?
    private var exp : REExperience!
    var experience : REExperience!{
        get{
            return self.exp
        }
        set(value){
            self.exp = value
            
            self.lblTitle.text = value.title
            self.lblInstitution.text = value.local
            self.lblStartEndDate.text = value.getStartEndDate()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInstitution: UILabel!
    @IBOutlet weak var lblStartEndDate: UILabel!
    @IBOutlet weak var btMoreInfo: UIButton!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 132
        
        self.btMoreInfo.hidden = true
    }
    
    // MARK: - Other functions
    func addInfoAction(action: ()->()){
        self.btMoreInfo.hidden = false
        self.infoAction = action
    }
    
    // MARK: - Actions
    @IBAction func btInfoTouchUpInsideAction(sender: UIButton) {
        if(self.infoAction != nil)
        {
            self.infoAction!()
        }
    }
    
}
