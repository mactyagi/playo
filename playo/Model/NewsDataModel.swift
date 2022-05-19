//
//  NewsDataModel.swift
//  playo
//
//  Created by manukant tyagi on 18/05/22.
//

import UIKit

// MARK: - NewsDataModel
struct NewsDataModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}


//a409d8952dae4ca2b593d4a277b7c374
func getApiCall(comp: @escaping (_ data: NewsDataModel?)-> Void){
    let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a409d8952dae4ca2b593d4a277b7c374")
    if let unwrappedURL = url {
        let request = URLRequest(url: unwrappedURL)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                    let json = try? JSONDecoder().decode(NewsDataModel.self, from: data)
                comp(json)
                    }
        }
        dataTask.resume()
    }
}

func downsample(imageAt imageURL: URL,
                to pointSize: CGSize,
                scale: CGFloat = UIScreen.main.scale, comp: @escaping (_ image: UIImage?) -> Void){

    // Create an CGImageSource that represent an image
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
        comp(nil)
        return
        
    }
    
    // Calculate the desired dimension
    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
    
    // Perform downsampling
    let downsampleOptions = [
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceShouldCacheImmediately: true,
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
    ] as CFDictionary
    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
        comp(nil)
        return
        
    }
    
    // Return the downsampled image as UIImage
    comp(UIImage(cgImage: downsampledImage))
//    return UIImage(cgImage: downsampledImage)
}

