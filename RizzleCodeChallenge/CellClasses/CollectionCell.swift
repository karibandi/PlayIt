//
//  CollectionCell.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var thumbNailImage:GetThumbnailImage!
    @IBOutlet weak var imageCard:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.thumbNailImage.layer.cornerRadius = 10.0
    }
}
