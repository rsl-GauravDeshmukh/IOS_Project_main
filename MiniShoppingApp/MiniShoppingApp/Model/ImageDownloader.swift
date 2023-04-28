//
//  ImageDownloader.swift
//  MiniShoppingApp
//
//  Created by Gaurav Deshmukh on 11/04/23.
//

import UIKit

class ImageDownloader {
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
}
