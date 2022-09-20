//
//  NewsData.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import Foundation

struct NewsData: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let publishedAt: String?
    let urlToImage: String?
}
