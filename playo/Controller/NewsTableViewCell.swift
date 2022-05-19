//
//  NewsTableViewCell.swift
//  playo
//
//  Created by manukant tyagi on 18/05/22.
//

import UIKit
import SDWebImage
class NewsTableViewCell: UITableViewCell {
    //MARK: - properties
    var size: CGSize = CGSize(width: 100, height: 100)
    var urlString: String = "" {
        didSet{
            newsImageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil, options: .progressiveLoad)
        }
    }
    
    //MARK: - IB Outlet
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
        
//        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.green.cgColor
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
