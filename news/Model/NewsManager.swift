//
//  NewsManager.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import Foundation

struct NewsManager {
    
    let baseURL = "https://newsapi.org/v2/everything?q=bitcoin&apiKey="
    let apiKey = "7b165f204f464ee98de2660c031777b6"
    
    func getData() {
        let urlString = baseURL + apiKey
        guard let url = URL(string: urlString) else {
            fatalError("Error getting URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error in task session")
                return
            }
            guard let safeData = data else {
                fatalError("Error getting data")
            }
            // what will happen if success
        }
        task.resume()
    }
}
