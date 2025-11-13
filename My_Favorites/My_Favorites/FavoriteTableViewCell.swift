//
//  FavoriteTableViewCell.swift
//  My_Favorites
//
//  Created by Амина Мамырбекова on 11.11.2025.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewLabel.numberOfLines = 0
        reviewLabel.lineBreakMode = .byWordWrapping
    }
    
    
    func configure(with item: FavoriteItem) {
        itemImageView.image = item.image
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        reviewLabel.text = item.review
    }
    
}
