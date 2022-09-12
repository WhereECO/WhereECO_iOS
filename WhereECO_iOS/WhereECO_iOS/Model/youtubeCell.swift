//
//  youtubeCell.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/12.
//

import UIKit

class youtubeCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
    
}
