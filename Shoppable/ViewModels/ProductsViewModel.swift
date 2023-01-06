//
//  ProductsViewModel.swift
//  Test
//
//  Created by Melisa Dlg on 04/01/2023.
//

import Foundation

protocol ProductsViewModelDelegate: AnyObject {
    func didTapGoToCatalog()
    func shouldUpdateCartBadge()
}

public class ProductsViewModel: ObservableObject, Identifiable {
    @Published var cartProducts: [Product] = []
    @Published var wishlistProducts: [Product] = []
    @Published var productsResponse: ProductsResponse?
    
    private let service: CatalogService
    static let shared = ProductsViewModel()
    weak var delegate: ProductsViewModelDelegate?
    
    init() {
        self.service = CatalogService()
        productsResponse = service.getResponse()
    }
    
    var products: [Product] {
        return productsResponse?.products ?? []
    }
    
    func addToCart(_ product: Product) {
        if isProductInCart(product) {
            var newProduct = cartProducts.first(where: { $0.id == product.id })
            newProduct?.increaseQuantity()
            
            if let row = cartProducts.firstIndex(where: { $0.id == product.id }) {
                cartProducts[row] = newProduct ?? product
            }
        } else {
            cartProducts.append(product)
        }
        delegate?.shouldUpdateCartBadge()
    }
    
    func deleteFromCart(_ product: Product) {
        if product.amount == 1 {
            cartProducts.removeAll(where: { $0.id == product.id })
        } else {
            var newProduct = cartProducts.first(where: { $0.id == product.id })
            newProduct?.decreaseQuantity()
            
            if let row = cartProducts.firstIndex(where: { $0.id == product.id }) {
                cartProducts[row] = newProduct ?? product
            }
        }
        delegate?.shouldUpdateCartBadge()
    }
    
    private func addToWishlist(_ product: Product) {
        wishlistProducts.append(product)
    }
    
    private func deleteFromWishlist(_ product: Product) {
        wishlistProducts.removeAll(where: { $0.id == product.id })
    }
    
    func toggle(product: Product) {
        if isProductInWishlist(product) {
            deleteFromWishlist(product)
        } else {
            addToWishlist(product)
        }
    }
    
    func goToCatalogScreen() {
        delegate?.didTapGoToCatalog()
    }
    
    func isProductInWishlist(_ product: Product) -> Bool {
        return wishlistProducts.contains(where: { $0.id == product.id })
    }
    
    func isProductInCart(_ product: Product) -> Bool {
        return cartProducts.contains(where: { $0.id == product.id })
    }
    
    var total: String {
        // get the sum of all the product's values multiplied by their own amount
        let sum = cartProducts.compactMap({ (($0.price?.value ?? 0.0) * Double($0.amount)) }).reduce(0, +)
        // assuming the currency of all products is the same
        let currency = cartProducts.compactMap({ $0.price?.currency }).unique().first
        return sum.getDisplayPrice(forCurrency: currency) ?? "0.0"
    }
    
    var cartCount: Int {
        return cartProducts.compactMap({ $0.amount }).reduce(0, +)
    }
}
