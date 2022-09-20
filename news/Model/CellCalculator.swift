//
//  CellCalculator.swift
//  news
//
//  Created by Macbook on 19.09.2022.
//

import UIKit

struct Sizes {
    var descriptionLabelFrame: CGRect
    var bottomViewFrame: CGRect
    var titleLabelFrame: CGRect
    var imageFrame: CGRect
    var totalHeight: CGFloat
}

final class CellCalculator {
    private let screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    
    func sizes(title: String?, description: String?, imageSize: CGSize?) -> Sizes {
        print(imageSize)
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: - titleLabel Frame
        
        var titleLabelFrame = CGRect(origin: CGPoint(x: Constants.cardInsets.left, y: Constants.cardInsets.top), size: CGSize.zero)
        
        if let text = title, !text.isEmpty {
            let width = cardViewWidth - Constants.titleInsets.left - Constants.titleInsets.right
            let height = text.height(width: width, font: Constants.titleFont)
            titleLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - descriptionLabel Frame
        
        var topInset = Constants.cardInsets.top
        
        if titleLabelFrame.size != CGSize.zero {
            topInset += titleLabelFrame.size.height
        }
        var descriptionLabelFrame = CGRect(origin: CGPoint(x: Constants.cardInsets.left, y: topInset), size: CGSize.zero)
        
        if let text = description, !text.isEmpty {
            let width = cardViewWidth - Constants.titleInsets.left - Constants.titleInsets.right
            let height = text.height(width: width, font: Constants.descriptionFont)
            descriptionLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - image frame
        
        let imageTop = max(titleLabelFrame.maxY, descriptionLabelFrame.maxY)
        var imageFrame = CGRect(origin: CGPoint(x: 0, y: imageTop), size: CGSize(width: cardViewWidth, height: 0))
        
//        if let imageSize = imageSize {
//            let imageHeight = CGFloat(imageSize.height) / CGFloat(imageSize.width) * cardViewWidth
//            imageFrame.size = CGSize(width: cardViewWidth, height: imageHeight)
//        }
        
        //MARK: - bottomView Frame
        
        var bottomViewTop = descriptionLabelFrame.maxY
        if imageSize?.height != 0 {
            bottomViewTop += imageSize?.height ?? 0
        }
        let bottomViewFrame = CGRect(x: 0, y: bottomViewTop, width: cardViewWidth, height: Constants.bottomViewHight)
        
        //MARK: - totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(descriptionLabelFrame: descriptionLabelFrame,
                     bottomViewFrame: bottomViewFrame,
                     titleLabelFrame: titleLabelFrame,
                     imageFrame: imageFrame,
                     totalHeight: totalHeight)
    }
}

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
    
}
