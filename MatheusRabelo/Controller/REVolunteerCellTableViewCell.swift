//
//  REVolunteerCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 17/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REVolunteerCellTableViewCell: RETableViewCell {
    // MARK: - Vars
    private var vol : REVolunteer!
    var volunteer : REVolunteer! {
        get{
            return self.vol
        }
        set(value){
            self.vol = value
            
            self.lblDescription.text = value.descript
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 147
        
    }
}
