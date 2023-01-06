//
//  CatalogService.swift
//  Shoppable
//
//  Created by Melisa Dlg on 06/01/2023.
//

import Foundation

struct CatalogService {
    
    func getResponse() -> ProductsResponse? {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json"),
              let jsonData = try? Data(contentsOf: url)
        else {
            print("Json file not found")
            return nil
        }
        
        let response = try? JSONDecoder().decode(ProductsResponse.self, from: jsonData)
        return response
    }
}
