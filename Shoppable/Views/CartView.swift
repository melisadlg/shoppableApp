//
//  CartView.swift
//  Shoppable
//
//  Created by Melisa Dlg on 06/01/2023.
//

import SwiftUI

public class CartViewWrapper: HostingSwiftUIView {
    public var viewModel: ProductsViewModel? {
        didSet {
            guard let model = viewModel
            else { return }
            let cartView = CartView(viewModel: model)
            self.hostingViewController = UIHostingController(rootView: cartView)
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

struct CartView: View {
    @StateObject var viewModel: ProductsViewModel
    
    private let placeholderURL = Constants.URLS.placeholerImage
    
    fileprivate func cartProductView(withProduct product: Product) -> some View {
        return HStack {
            AsyncImage(url: URL(string: product.imageURL ?? placeholderURL), scale: 4)

            VStack(alignment: .leading, spacing: 5) {
                Text(product.name ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)

                Text(product.description ?? "")
                    .font(.caption2)
                    .foregroundColor(Color.gray)

                Text(product.price?.displayPrice ?? "")
                    .font(.caption2)


                Spacer()
                HStack {
                    Text(Constants.Tabs.Cart.productAmount)
                        .font(.caption2)
                        .fontWeight(.bold)
                    Text("\(product.amount)")
                        .font(.caption2)
                        .fontWeight(.bold)
                }

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
                        viewModel.deleteFromCart(product)
                    } label: {
                        Image(systemName: Constants.Images.removeItem)
                    }

                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }

    fileprivate func cartView() -> some View {
        return VStack {
            if !viewModel.cartProducts.isEmpty {
                ScrollView {
                    ForEach(viewModel.cartProducts.unique()) { product in
                        cartProductView(withProduct: product)
                        Divider()
                    }
                }
                .scrollIndicators(.hidden)

                HStack {
                    Text(Constants.Tabs.Cart.total)
                        .fontWeight(.bold)
                    Spacer()
                    Text(viewModel.total)
                }

            } else {
                VStack(alignment: .center, spacing: 48) {
                    Text(Constants.Tabs.Cart.emptyStateText)

                    Button(action: {
                        viewModel.goToCatalogScreen()
                    }) {
                        Text(Constants.Tabs.Cart.emptyStateButton)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                }
            }
        }
        .padding()
    }
    
    var body: some View {
        NavigationView {
            cartView()
                .navigationTitle(Constants.Tabs.Cart.title)
        }
    }
}
