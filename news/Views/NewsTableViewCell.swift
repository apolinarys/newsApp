//
//  NewsTableViewCell.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    let newsImage: WebImageView = {
        let imageView = WebImageView()
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 12),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            
            authorLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 8),
            authorLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),
            authorLabel.heightAnchor.constraint(equalToConstant: Constants.bottomViewHight),
            
            dateLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),
            dateLabel.heightAnchor.constraint(equalToConstant: Constants.bottomViewHight),
        ])
    }
    
    private func addSubviews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(bottomView)
        cardView.addSubview(newsImage)
        bottomView.addSubview(authorLabel)
        bottomView.addSubview(dateLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    func set(newsModel: NewsModel) {
        let cellCalculator = CellCalculator()
        var imageSize = CGSize.zero
        DispatchQueue.main.async {
            self.newsImage.set(imageURL: newsModel.imageURL)
            self.titleLabel.text = newsModel.title
            self.descriptionLabel.text = newsModel.description
            self.authorLabel.text = newsModel.author
            self.dateLabel.text = newsModel.date
            if let image = self.newsImage.image{
                imageSize = CGSize(width: image.size.height, height: image.size.width)
            }
            let sizes = cellCalculator.sizes(title: newsModel.title, description: newsModel.description, imageSize: imageSize)
            
            self.newsImage.frame = sizes.imageFrame
            self.titleLabel.frame = sizes.titleLabelFrame
            self.descriptionLabel.frame = sizes.descriptionLabelFrame
            self.bottomView.frame = sizes.bottomViewFrame
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
