//
//  UIImageView.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit
import SDWebImage

extension UIImageView {

    func loadImage(
        url: String,
        showPlaceholder: Bool = true,
        placeholderImageString: String = "default_icon"
    ) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!),
                         placeholderImage: showPlaceholder ?  #imageLiteral(resourceName: placeholderImageString) : UIImage())
    }

    func loadImage(
        imageURL: String,
        showPlaceholder: Bool = true,
        placeholderImageString: String = "default_icon",
        completion: @escaping ((_ image: UIImage) -> Void)
    ) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!),
                         placeholderImage: showPlaceholder ?  #imageLiteral(resourceName: placeholderImageString) : UIImage(),
                         options: SDWebImageOptions(rawValue: 0), completed: { image, _, _, _ in
                            if let loadedImage = image {
                                completion(loadedImage)
                            } else {
                                completion(UIImage())
                            }
        })
    }
}
