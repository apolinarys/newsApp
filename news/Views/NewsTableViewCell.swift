//
//  NewsTableViewCell.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let reuseId = "NewsTableViewCell"
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Description"
        label.textAlignment = .center
        return label
    }()
    
    let newsImage: WebImageView = {
        let imageView = WebImageView()
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "noImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        
        let size = newsImage.updateImageSize(image: UIImage(named: "noImage")!)
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            
            newsImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            newsImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            newsImage.heightAnchor.constraint(equalToConstant: size.height),
            newsImage.widthAnchor.constraint(equalToConstant: size.width),
            
            authorLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 8),
            authorLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
            authorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8),
            
            dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
            dateLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8),
            dateLabel.widthAnchor.constraint(equalToConstant: 135)
        ])
    }
    
    private func addSubviews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(newsImage)
        cardView.addSubview(authorLabel)
        cardView.addSubview(dateLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    func set(newsModel: NewsModel.Cell) {
            self.newsImage.set(imageURL: newsModel.imageURL)
            self.titleLabel.text = newsModel.title
            self.descriptionLabel.text = newsModel.description
            self.authorLabel.text = newsModel.author
            self.dateLabel.text = newsModel.date
    }
    
    override func prepareForReuse() {
        newsImage.image = UIImage(named: "noImage")
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
