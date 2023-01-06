//
//  ViewController.swift
//  Shoppable
//
//  Created by Melisa Dlg on 05/01/2023.
//

import UIKit

class ProductCatalogViewController: UIViewController {
    
    @IBOutlet weak var catalogViewWrapper: CatalogViewWrapper!
    
    let viewModel = ProductsViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        catalogViewWrapper.viewModel = viewModel
    }
}

extension ProductCatalogViewController: ProductsViewModelDelegate {
    func didTapGoToCatalog() { }
    
    func shouldUpdateCartBadge() {
        if let tabBarController = self.parent as? UITabBarController,
           let cart = tabBarController.viewControllers?[1] as? CartViewController {
            cart.tabBarItem.badgeValue = (viewModel.cartCount >= 1) ? "\(viewModel.cartCount)" : nil
        }
    }
}
