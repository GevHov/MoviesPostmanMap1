//
//  UIImageViewExtension.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 21.12.21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
