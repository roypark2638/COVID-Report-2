//
//  NewsArticleCell.swift
//  COVID Report
//
//  Created by Roy Park on 12/9/20.
//

import UIKit

class NewsArticleCell: UITableViewCell {
//   dateInfectedView.setCornerAndShadowToUIView(radius: 5, color: .darkGray, offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var newsArticleImage: UIImageView!
    @IBOutlet weak var newsHeadingLabel: UILabel!
    @IBOutlet weak var newsSubLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        newsArticleImage.layer.cornerRadius = 10
        viewCell.layer.cornerRadius = 10
        viewCell.layer.shadowRadius = 5
        viewCell.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewCell.layer.shadowRadius = 10
        viewCell.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
