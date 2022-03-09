//
//  Extensions.swift
//  Example2
//
//  Created by Vahagn Yeghoyan on 11.11.21.
//

import UIKit


//MARK: - Remote ImageURL
extension UIImageView {
    
    func load(url: URL){
        DispatchQueue.global().async {
            [weak self] in if let data = try? Data(contentsOf: url){
                if let imageView = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = imageView
                    }
                }
            }
        }
    }
}
