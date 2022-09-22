//
//  NewsModel.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import Foundation
import UIKit

struct NewsModel {
    
    struct Cell{
        let author: String?
        let title: String?
        let description: String?
        let date: String?
        let url: String?
        let imageURL: String?
        let image: Data?
    }
    
    var cells: [Cell]
}
