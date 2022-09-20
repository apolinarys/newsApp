//
//  FeedManager.swift
//  news
//
//  Created by Macbook on 20.09.2022.
//

import UIKit

class CellViewModel{
    
    var viewController: ViewController?
    var newsData: NewsData?
    let cellCalculator = CellCalculator()
    
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
    
    func getData() {
        print("get data")
        let cells = newsData?.articles.map({ newsArticle in
            cellViewModel(from: newsArticle)
        })
        if let cells = cells {
            let newsModel = NewsModel(cells: cells)
            print(newsModel)
            viewController?.displayData(newsModel: newsModel)
        }
    }
    
    private func cellViewModel(from newsArticle: Article) -> NewsModel.Cell {
        
        var imageSize = CGSize.zero
        
        if let imageURL = newsArticle.urlToImage, let url = URL(string: imageURL) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                
                    if let data = data, let _ = response {
                        let image = UIImage(data: data)
                        imageSize = image?.size ?? CGSize.zero
                    }
            }
            dataTask.resume()
        }
        
        let sizes = cellCalculator.sizes(title: newsArticle.title, description: newsArticle.description, imageSize: imageSize)
        
        return NewsModel.Cell(author: newsArticle.author,
                              title: newsArticle.title,
                              description: newsArticle.description,
                              date: newsArticle.publishedAt,
                              imageURL: newsArticle.urlToImage,
                              sizes: sizes)
    }
}
