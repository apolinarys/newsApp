//
//  FeedManager.swift
//  news
//
//  Created by Macbook on 20.09.2022.
//

import UIKit
import CoreData

class CellViewModel{
    
    let dataManager = DataManager()
    
    var viewController: ViewController?
    var newsData: NewsData?
    
    func presentData() {
        let newsManager = NewsManager()
        print("present data")
        
        newsManager.getFeed { data in
            self.newsData = data
            DispatchQueue.main.async {
                self.getData()
            }
        }
    }
    
    private func getData() {
        print("get data")
        let cells = newsData?.articles.map({ newsArticle in
            cellViewModel(from: newsArticle)
        })
        if let cells = cells {
            let newsModel = NewsModel(cells: cells)
            viewController?.displayData(newsModel: newsModel)
        }
    }
    
    private func cellViewModel(from newsArticle: Article) -> NewsModel.Cell {
        
        let dateString: String?
        
        if let string = newsArticle.publishedAt {

            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale // save locale temporarily
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: string)!
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale
            dateString = dateFormatter.string(from: date)
        } else {
            dateString = nil
        }
        
        return NewsModel.Cell(author: newsArticle.author,
                              title: newsArticle.title,
                              description: newsArticle.description,
                              date: dateString,
                              url: newsArticle.url,
                              imageURL: newsArticle.urlToImage,
                              image: nil)
    }
    
}
