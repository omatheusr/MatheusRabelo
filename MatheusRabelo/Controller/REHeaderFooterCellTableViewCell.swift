//
//  REHeaderFooterCellTableViewCell.swift
//  MatheusRabelo
//
//  Created by Matheus Oliveira Rabelo on 15/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import UIKit

class REHeaderFooterCellTableViewCell: RETableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        super.height = 40
    }
    
    // MARK: - Other functions
    func setImage(imageName: String, color: UIColor)
    {
        self.imgBackground.image = UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgBackground.tintColor = color
    }
}
