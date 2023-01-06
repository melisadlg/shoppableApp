//
//  ShoppableTests.swift
//  ShoppableTests
//
//  Created by Melisa Dlg on 05/01/2023.
//

import XCTest
@testable import Shoppable

final class ShoppableTests: XCTestCase {
    
    var productsViewModel: ProductsViewModel?
    
    private let testProduct = Product(id: "111", name: "Malmo", price: Price(value: 99.99, currency: Currency.kr), info: Info(material: "Wood", color: "Green", numberOfSeats: 2), type: ProductType.couch, imageURL: nil, uniqueID: UUID(), amount: 1)
    
    override func setUpWithError() throws {
        super.setUp()
        productsViewModel = ProductsViewModel()
    }

    override func tearDownWithError() throws {
        productsViewModel = nil
        super.tearDown()
    }

    func testResponse() {
        XCTAssertEqual(productsViewModel?.products.count, 14)
    }

    func testAddToCart() throws {
        productsViewModel?.addToCart(testProduct)
        
        let productIsInCart = try XCTUnwrap(productsViewModel?.isProductInCart(testProduct))
        XCTAssertTrue(productIsInCart)
        
        XCTAssertEqual(productsViewModel?.cartCount, 1)
        
        let formattedPrice = try XCTUnwrap(newProduct.price?.value?.getDisplayPrice(forCurrency: .kr))
        XCTAssertEqual(productsViewModel?.total, formattedPrice)
    }
    
    func testRemoveFromCart() throws {
        productsViewModel?.deleteFromCart(testProduct)
        
        let productIsNotCart = try XCTUnwrap(productsViewModel?.isProductInCart(testProduct))
        XCTAssertFalse(productIsNotCart)
        
        XCTAssertEqual(productsViewModel?.cartCount, 0)
    }
    
}

final class CommonUtilsExtensionsTests: XCTestCase {
    func testPriceFormat() throws {
        let input = 695.20
        let expectedOutput = "695,20 kr"
        let formattedPrice = try XCTUnwrap(input.getDisplayPrice(forCurrency: .kr))
        XCTAssertEqual(formattedPrice, expectedOutput, "Price is not correctly formatted.")
    }
}
