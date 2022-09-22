//
//  NewsManager.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import Foundation
import UIKit

struct NewsManager {
    
    let baseURL = "https://newsapi.org/v2/top-headlines?language=en&pageSize=100&apiKey="
    let apiKey = "7b165f204f464ee98de2660c031777b6"
    
    func getFeed(response: @escaping (NewsData?) -> Void) {
        
        request { data, error in
            if let error = error {
                print("Error receiving requested data: \(error)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: NewsData.self, from: data)
            response(decoded)
        }
    }
    
    private func request(completion: @escaping(Data?, Error?) -> Void) {
        let urlString = baseURL + apiKey
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil}
        return response
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
