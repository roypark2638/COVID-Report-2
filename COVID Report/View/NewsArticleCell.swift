//
//  NewsArticleCell.swift
//  COVID Report
//
//  Created by Roy Park on 12/9/20.
//

import UIKit

class NewsArticleCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var newsArticleImage: UIImageView!
    @IBOutlet weak var newsHeadingLabel: UILabel!
    @IBOutlet weak var newsSubLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsArticleImage.layer.cornerRadius = 5
        newsArticleImage.layer.shadowRadius = 3
        newsArticleImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        newsArticleImage.layer.shadowRadius = 5
        newsArticleImage.layer.shadowOpacity = 0.3
        newsArticleImage.layer.cornerRadius = 5
//        viewCell.layer.shadowRadius = 3
//        viewCell.layer.shadowOffset = CGSize(width: 3, height: 3)
//        viewCell.layer.shadowRadius = 5
//        viewCell.layer.shadowOpacity = 0.3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension UIImageView {
    public func imageFromURL(urlString: String) {

        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })

        }).resume()
    }
}
