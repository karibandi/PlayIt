//
//  FetchThumbNails.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import Foundation
import UIKit
import AVKit

let thumbnailCache = NSCache<AnyObject, UIImage>()
class GetThumbnailImage:UIImageView{
    var dataTask: URLSessionDataTask?
    func loadImageFromURLS(imageURL: URL, placeholderImage: String){
        if let cachedImage = thumbnailCache.object(forKey: imageURL as AnyObject){
            self.image = cachedImage
        }
        DispatchQueue.global().async {  [weak self] in
            let asset = AVAsset(url: imageURL)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 1, timescale: 1)
            do {
                    let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                    let thumbNailImage = UIImage(cgImage: cgThumbImage)
                    DispatchQueue.main.async {
                        thumbnailCache.setObject(thumbNailImage, forKey: imageURL as AnyObject)
                        self?.image = thumbNailImage
                    }
                    } catch {
                        DispatchQueue.main.async {
                            self?.image = UIImage(named: "Noimage")
                        }
                        print(error.localizedDescription)
                    }
        }
    }

}



