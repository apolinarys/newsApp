//
//  WebImageView.swift
//  news
//
//  Created by Macbook on 20.09.2022.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String?) {
        
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return}
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            DispatchQueue.main.async {
                let image = UIImage(data: cachedResponse.data)
                self.image = image
                return
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    let image = UIImage(data: data)
                    self?.image = image
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {return}
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
