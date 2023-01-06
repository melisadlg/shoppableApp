//
//  CartViewController.swift
//  Shoppable
//
//  Created by Melisa Dlg on 06/01/2023.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartViewWrapper: CartViewWrapper!
    
    let viewModel = ProductsViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        cartViewWrapper.viewModel = viewModel
    }
}

extension CartViewController: ProductsViewModelDelegate {
    func didTapGoToCatalog() {
        if let tabBarController = self.parent as? UITabBarController {
            tabBarController.selectedIndex = 0
        }
    }
    
    func shouldUpdateCartBadge() {
        tabBarItem.badgeValue = (viewModel.cartCount >= 1) ? "\(viewModel.cartCount)" : nil
    }
}
