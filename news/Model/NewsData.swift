//
//  NewsData.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import Foundation

struct Articles: Decodable {
    let articles: [Items]
}

struct Items: Decodable {
    let author: String
    let title: String
    let description: String
    let publishedAt: String
    let urlToImage: String
}
