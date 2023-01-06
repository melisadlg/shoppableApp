//
//  ContentView.swift
//  Test
//
//  Created by Melisa Dlg on 02/01/2023.
//

import SwiftUI

public class CatalogViewWrapper: HostingSwiftUIView {
    public var viewModel: ProductsViewModel? {
        didSet {
            guard let model = viewModel
            else { return }
            let catalogView = CatalogView(viewModel: model)
            self.hostingViewController = UIHostingController(rootView: catalogView)
            setupUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

struct CatalogView: View {
    @StateObject var viewModel: ProductsViewModel
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    private let placeholderURL = Constants.URLS.placeholerImage
    
    fileprivate func catalogProductView(withProduct product: Product) -> some View {
        return VStack {
            AsyncImage(url: URL(string: product.imageURL ?? placeholderURL), scale: 4)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name ?? "")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black)
                
                
                Text(product.description ?? "")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
                
                Text(product.price?.displayPrice ?? "")
                    .font(.caption2)
                
               
                HStack {
                    Button {
                        viewModel.toggle(product: product)
                    } label: {
                        if viewModel.isProductInWishlist(product) {
                            Image(systemName: Constants.Images.wishlistSelected)
                        } else {
                            Image(systemName: Constants.Images.wishlistNormal)
                        }
                        
                    }
                    Spacer()
                    
                    Button {
                        viewModel.addToCart(product)
                    } label: {
                        Image(systemName: Constants.Images.addToCart)
                    }
                    
                }
            }
        }
    }
    
    fileprivate func catalogView() -> some View {
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(viewModel.products) { product in
                    catalogProductView(withProduct: product)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
    var body: some View {
        NavigationView {
            catalogView()
                .navigationTitle(Constants.Tabs.Catalog.title)
        }
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
    }
}
