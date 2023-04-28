//
//  CartView.swift
//  rootTabVC
//
//  Created by Gaurav Deshmukh on 30/03/23.
//

import UIKit

class CartView: UIView {
    
    let emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart is empty"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let browseProductsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Browse products", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(emptyCartLabel)
        addSubview(browseProductsButton)
        
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            
            browseProductsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            browseProductsButton.topAnchor.constraint(equalTo: emptyCartLabel.bottomAnchor, constant: 32),
            browseProductsButton.widthAnchor.constraint(equalToConstant: 200),
            browseProductsButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        browseProductsButton.addTarget(self, action: #selector(browseProductsTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func browseProductsTapped() {
        // Navigate to Home tab
        
        if let tabBarController = viewController?.tabBarController {
            tabBarController.selectedIndex = 0
        }
    }
    
    private var viewController: UIViewController? {
            var nextResponder = self.next
            while nextResponder != nil {
                if let viewController = nextResponder as? UIViewController {
                    return viewController
                }
                nextResponder = nextResponder?.next
            }
            return nil
        }
}
           

