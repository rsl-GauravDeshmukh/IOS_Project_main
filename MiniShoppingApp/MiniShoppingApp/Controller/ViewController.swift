//
//  ViewController.swift
//  MiniShoppingApp
//
//  Created by Gaurav Deshmukh on 20/03/23.
//

import UIKit

class ViewController: UIViewController {

    private let customView = FirstView()
    var productArray:[Products] = []
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        view.addSubview(customView)
        setCustomViewConstraints()
        setCollectionView()
        fetchData()
        setSlider()
        // Retrieve the cart items from UserDefaults
        if let savedData = defaults.object(forKey: "mydata") as? Data {
            let decoder = PropertyListDecoder()
            if let cartItems = try? decoder.decode([Products].self, from: savedData) {
                Cart.shared.cartItems = cartItems
            }
        }
    }
    
    private func setNavBar() {
        title = "Mini-Shopping"
        view.backgroundColor = .white
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
    
    private func setCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.indetifier)
    }
    
    private func fetchData() {
        if let url = URL(string: "https://dummyjson.com/products") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error == nil {
                    if let safeData = data {
                        self.parseJSON(productsData: safeData)
                        
                        DispatchQueue.main.async {
                            self.customView.collectionView.reloadData()
                        }
                }
                
                
            }
            else {
                print("### error Ocurred.. !!!")
                }
            }.resume()
        }
    }
    
    
    private func parseJSON(productsData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodableData = try decoder.decode(ProductArray.self, from: productsData)
            self.productArray =  decodableData.products
            
        }
        
        catch {
            print("error in JSON parsing")
        }
        
    }
    
    private func setSlider() {
        customView.slider.addTarget(self, action: #selector(sliderValChanged), for: .valueChanged)
    }
    
    @objc private func sliderValChanged() {
        let currentVal = customView.slider.value
        
        var sortArray:[Products] = []
        var i = 0;
        print(currentVal)
        while(i<productArray.count) {
            let product = productArray[i]
            if(product.price <= Double(currentVal))
            {
                sortArray.append(product)
            }
            i = i+1
        }
        productArray = sortArray
        print(productArray.count)
        customView.collectionView.reloadData()
        
    }
    
    @objc func cartButtonDidTap(_ sender: UIButton) {
        
        if let cell = sender.superview?.superview as? ProductCollectionViewCell, let indexPath =  customView.collectionView.indexPath(for: cell) {
            Cart.shared.cartItems.append(productArray[indexPath.row])
            let encoder = PropertyListEncoder()
            if let encodedData = try? encoder.encode(Cart.shared.cartItems) {
                defaults.set(encodedData, forKey: "mydata")
            }
        }
        else  {
            print("error")
            return
        }
    }
}


extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customView.collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.indetifier, for: indexPath) as! ProductCollectionViewCell
        
        let product = productArray[indexPath.row]
        cell.setImage(url: product.thumbnail)
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "$\(product.price)"
        cell.categoryLabel.text = product.category
        cell.cartButton.addTarget(self, action: #selector(cartButtonDidTap), for: .touchUpInside)
        
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

