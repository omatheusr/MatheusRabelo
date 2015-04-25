//
//  REEducationCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 16/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REEducationCellTableViewCell: RETableViewCell {

    // MARK: - Vars
    private var edu : REEducation!
    
    var education : REEducation! {
        get{
            return self.edu
        }
        set(value){
            self.edu = value
            
            self.lblTitle.text = value.courseName
            self.lblInstitutionName.text = value.institutionName
            self.lblInstitutionShort.text = value.institutionShort
            self.lblStartEndDate.text = value.getStartEndDate()
        }
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInstitutionName: UILabel!
    @IBOutlet weak var lblInstitutionShort: UILabel!
    @IBOutlet weak var lblStartEndDate: UILabel!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 147
    }
}
