//
//  ProductResponse.swift
//  Test
//
//  Created by Melisa Dlg on 02/01/2023.
//

import Foundation

// MARK: ProductsResponse
struct ProductsResponse: Codable {
    let products: [Product]?
}

// MARK: Product
struct Product: Codable, Identifiable, Hashable {
    let id, name: String?
    let price: Price?
    let info: Info?
    let type: ProductType?
    let imageURL: String?
    var uniqueID = UUID()

    enum CodingKeys: String, CodingKey {
        case id, name, price, info, type
        case imageURL = "imageUrl"
    }
    
    var amount: Int = 1
    
    mutating func increaseQuantity() {
        amount+=1
    }
    
    mutating func decreaseQuantity() {
        amount-=1
    }
}

extension Product {
    var description: String? {
        guard let productInfo = info
        else { return nil }
        
        var attributes = [String]()
        
        switch type {
        case .chair:
            if let material = productInfo.material {
                attributes.append(material)
            }
        case .couch:
            if let seats = productInfo.numberOfSeats {
                attributes.append("\(seats) seats")
            }
        case .none:
            break
        }
        
        if let color = productInfo.color {
            attributes.append(color)
        }
        
        return attributes.joined(separator: ", ").capitalized
    }
}

// MARK: Info
struct Info: Codable, Hashable {
    let material, color: String?
    let numberOfSeats: Int?
}

// MARK: Price
struct Price: Codable, Hashable {
    let value: Double?
    let currency: Currency?
}

extension Price {
    var displayPrice: String? {
        guard let price = value
        else { return nil }
        
        return price.getDisplayPrice(forCurrency: currency)
    }
}

// MARK: Enums
enum Currency: String, Codable {
    case kr = "kr"
    
    var ISOcode: String {
        switch self {
        case .kr: return "SEK"
        }
    }
}

enum ProductType: String, Codable {
    case chair = "chair"
    case couch = "couch"
}

