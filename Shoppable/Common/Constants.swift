//
//  Constants.swift
//  Test
//
//  Created by Melisa Dlg on 05/01/2023.
//

import Foundation

struct Constants {
    
    struct Tabs {
        struct Cart {
            static let title = "Cart"
            static let emptyStateText = "No products in your bag,\n time to go shopping!"
            static let emptyStateButton = "Check out our catalog!"
            static let productAmount = "Amount: "
            static let total = "Total"
        }

        struct Catalog {
            static let title = "Catalog"
        }
    }
    
    struct URLS {
        static let placeholerImage = "https://cdn.dribbble.com/users/22136/screenshots/818781/ikea.jpg"
    }
    
    struct Images {
        static let catalogTab = "house.fill"
        static let cartTab = "bag"
        static let wishlistNormal = "heart"
        static let wishlistSelected = "heart.fill"
        static let addToCart = "bag.badge.plus"
        static let removeItem = "trash"
    }
}
