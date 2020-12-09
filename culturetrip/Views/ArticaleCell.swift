//
//  GenreCell.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit
import Nuke

class ArticaleCell:UICollectionViewCell {
    
    private struct consts {
        static let likeImage: UIImage = UIImage(named: "like") ?? UIImage()
        static let likedImage: UIImage = UIImage(named: "liked") ?? UIImage()
        static let saveImage: UIImage = UIImage(named: "save") ?? UIImage()
        static let savedImage: UIImage = UIImage(named: "saved") ?? UIImage()
    }
    
    //  MARK: outlets
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var saveImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!{
        didSet {
            avatarImage.layer.cornerRadius = 18
        }
    }
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    // MARK: proprieties
    static let identifier: String = "ArticaleCell"
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
    var data: Article? = nil {
        didSet {
            onDataSet(data)
        }
    }
    
    // MARK: inherit
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImage.image = nil
        self.topImage.image = nil
        self.likeImage.image = nil
        self.saveImage.image = nil
    }
    
    //Here is the magic
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    func onDataSet(_ article: Article?) {
        guard let article = article  else { return }
        if let urlPath = article.imageUrl, let url = URL(string: urlPath) {
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.2)), into: topImage)
        }
        if let urlPath = article.author?.authorAvatar?.imageUrl, let url = URL(string: urlPath) {
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.2)), into: avatarImage)
        }
        
        saveImage.image = (article.isSaved ?? false) ? consts.savedImage : consts.saveImage
        likeImage.image = (article.isLiked ?? false) ? consts.likedImage : consts.likeImage
        categoryLabel.text = article.category
        titleLabel.text = article.title
        authorLabel.text = article.author?.authorName
        dateLabel.text = article.metaData?.updateTime
        if let likes = article.likesCount{
            likeCountLabel.text = String(likes)
        } else {
            likeCountLabel.text = ""
        }
       
    }
}


