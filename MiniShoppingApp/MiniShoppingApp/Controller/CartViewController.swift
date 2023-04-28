//
//  CartViewController.swift
//  rootTabVC
//
//  Created by Gaurav Deshmukh on 30/03/23.
//

import UIKit

class CartViewController: UIViewController {

    let customView = CartWithItemView()
    var productArray:[Products]  = Cart.shared.cartItems
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        setCustomViewConstraints()
        setNavBar()
        setCollectionView()
        productArray  = Cart.shared.cartItems
        
    }
    
    private func setCustomViewConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
                
        let height = navigationController?.navigationBar.frame.height ?? 0
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: height-25),
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setNavBar() {
        title = "MyCart"
        navigationController?.navigationBar.backgroundColor = .systemTeal
        view.backgroundColor = .white
    }
    
    private func setCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.indetifier)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        productArray = Cart.shared.cartItems
        customView.collectionView.reloadData()
    }
    
    @objc func cartButttonDidTap(_ sender:UIButton) {
        if let cell = sender.superview?.superview as? CartCell, let indexPath =  customView.collectionView.indexPath(for: cell) {
            
            Cart.shared.cartItems.remove(at: indexPath.row)
            productArray = Cart.shared.cartItems
            customView.collectionView.reloadData()
            
            let defaults = UserDefaults.standard
            
            let encoder = PropertyListEncoder()
            if let encodedData = try? encoder.encode(Cart.shared.cartItems) {
                defaults.set(encodedData, forKey: "mydata")
            }
        }
    }

}

extension CartViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customView.collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.indetifier, for: indexPath) as! CartCell
        
        let product = productArray[indexPath.row]
        cell.setImage(url: product.thumbnail)
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "$\(product.price)"
        cell.categoryLabel.text = product.category
        cell.cartButton.addTarget(self, action: #selector(cartButttonDidTap), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Set the size of your cell here
           return CGSize(width: 380, height: 300)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            // set the inset of your UICollectionViewCell here (left, right, top, bottom)
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
}

