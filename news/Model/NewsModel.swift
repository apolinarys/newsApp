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
        let imageURL: String?
        var sizes: Sizes
    }
    
    let cells: [Cell]
}
