//
//  REProjectCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 4/25/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REProjectCellTableViewCell: UITableViewCell {

    //MARK: - Vars
    private var infoAction: (()->())?
    private var proj : REProject!
    
    var project : REProject! {
        get{
            return self.proj
        }
        set(value){
            self.proj = value
            
            self.lblTitle.text = self.proj.name
            self.imgLogo.image = UIImage(named: self.proj.imagename)
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btMoreInfo: UIButton!
    
    //MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgLogo.layer.masksToBounds = true
        self.imgLogo.layer.cornerRadius = 15
        self.btMoreInfo.hidden = true
    }
    //MARK: - Other Functions
    func addInfoAction(action: ()->())
    {
        self.btMoreInfo.hidden = false
        self.infoAction = action
    }
    
    //MARK: - Actions
    @IBAction func infoAction(sender : UIButton)
    {
        if(self.infoAction != nil)
        {
            self.infoAction!()
        }
    }

}
