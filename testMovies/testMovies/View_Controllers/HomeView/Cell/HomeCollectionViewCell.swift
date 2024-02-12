//
//  HomeCollectionViewCell.swift
//  testMovies
//
//  Created by Дмитрий Тимаров on 11.12.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    
  
    
    @IBOutlet weak var imagesOfCollections: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagesOfCollections.layer.cornerRadius = 6
        
        
        // Initialization code
    }

}
