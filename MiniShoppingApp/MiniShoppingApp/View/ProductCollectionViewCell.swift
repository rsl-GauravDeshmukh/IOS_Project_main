//
//  ProductCollectionViewCell.swift
//  BlockAssignment
//
//  Created by Gaurav Deshmukh on 21/03/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let indetifier = "Cell"
    
    let itemImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        return label
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        return label
    }()
    
    
    let cartButton:UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 15
        

        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(cartButton)
        setContentView()
        setConstraintsItemImageView()
        setConstraintsTitleLabel()
        setConstraintsDescriptionLabel()
        setConstraintsPriceLabel()
        setConstraintsCategoryLabel()
        setConstraintsCartButton()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentView()
    {
        contentView.backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
    
    private func setConstraintsItemImageView()
    {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalToConstant: 150),
            itemImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setConstraintsTitleLabel()
    {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setConstraintsDescriptionLabel()
    {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 170)
        ])
    }
    
    private func setConstraintsPriceLabel()
    {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant:40 ),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setConstraintsCategoryLabel()
    {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant:40 ),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        
    }
    
    private func setConstraintsCartButton() {
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            cartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cartButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            cartButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    func setImage(url: String) {
            itemImageView.image = UIImage(named: "Iphone")
        if let url1 = URL(string: url) {
            
            ImageDownloader.downloadImage(from: url1) { [weak self] image in
                DispatchQueue.main.async {
                    if let image = image, let `self` = self, self.itemImageView.image == UIImage(named: "Iphone") {
                        self.itemImageView.image = image
                    }
                }
            }
        }
    }
    
}
