//
//  Utils.swift
//  Test
//
//  Created by Melisa Dlg on 04/01/2023.
//

import Foundation

// MARK: Double
extension Double {
    
    func getDisplayPrice(forCurrency currency: Currency?) -> String? {
        let price = self
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.currencyCode = currency?.ISOcode
        formatter.usesGroupingSeparator = true
        let priceString = formatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return priceString
    }
    
}

// MARK: Sequence
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
