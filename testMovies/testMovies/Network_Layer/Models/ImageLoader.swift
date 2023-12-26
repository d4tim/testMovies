//
//  ImageLoader.swift
//  testMovies
//
//  Created by Makar Grushka on 26.12.2023.
//  AcquisitionImage.swift
//  testMovies

import Foundation
import UIKit

/*
 Это лоадер для картинок
 Базовый лоадер для картинок
 */

extension UIImageView {
    
    static let cacheData = NSCache<AnyObject, AnyObject>()
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let cachedImage = UIImageView.cacheData.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                if error != nil {
                    print("Error loading image: \(error!.localizedDescription)")
                    return
                }
                
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    print("Failed to convert data to image")
                    return
                }
                
                UIImageView.cacheData.setObject(downloadedImage, forKey: url as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }.resume()
        }
    }
}
