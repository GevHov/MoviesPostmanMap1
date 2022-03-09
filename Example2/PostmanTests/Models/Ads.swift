//
//  Ad.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 20.12.21.
//
import Foundation

// MARK: - Ad
class Ads: Codable {
    
    let id, state: Int
    let name: String?
    let userID, categoryID: Int
    let description: String?
    let image: String
    let owner: Int
    let isBestPrice: Bool?
    
}
