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
            self.image = UIImage(named: "noImage")
            return}
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            DispatchQueue.main.async {
                let image = UIImage(data: cachedResponse.data)
                self.image = image
                
            if let image = image {
                let size = self.updateImageSize(image: image)
                self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            }
                return
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    let image = UIImage(data: data)
                    self?.image = image
                    if let image = image {
                        let size = self!.updateImageSize(image: image)
                        self!.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                        self!.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                    }
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    func updateImageSize(image: UIImage) -> CGSize {
        let width: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 32
        let r = image.size.height / image.size.width
        let size = CGSize(width: width, height: r * width)
        return size
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {return}
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
