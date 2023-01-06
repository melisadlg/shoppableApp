//
//  HostingSwiftUIView.swift
//  Shoppable
//
//  Created by Melisa Dlg on 06/01/2023.
//

import UIKit

open class HostingSwiftUIView: UIView {
    
    public var hostingViewController: UIViewController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
   public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func setupUI() {
        guard let view = hostingViewController?.view else { return }
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
}
