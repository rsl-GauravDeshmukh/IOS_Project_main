//
//  FirstView.swift
//  BlockAssignment
//
//  Created by Gaurav Deshmukh on 20/03/23.
//

import UIKit

class FirstView: UIView {
    
    
    let sliderMinVal:UILabel = {
        let label = UILabel()
        label.text = "100"
        
        return label
    }()
    
    let sliderMaxVal:UILabel = {
        let label = UILabel()
        label.text = "10000"
        
        return label
    }()
    
    let slider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 100
        slider.maximumValue = 10000
        slider.value = 10000
        slider.maximumTrackTintColor = UIColor.red
        
        return slider
    }()

    let priceButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sort by Price", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.green, for: .highlighted)
        button.backgroundColor = .lightGray
        button.layer.borderWidth =  2
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = CGColor(red: 20, green: 50, blue: 100, alpha: 10)
        
        return button
    }()
    
    let categoryButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sort by Category", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.green, for: .highlighted)
        button.backgroundColor = .lightGray
        button.layer.borderWidth =  2
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = CGColor(red: 20, green: 50, blue: 100, alpha: 10)
        
        return button
    }()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .brown
        addSubview(sliderMinVal)
        addSubview(sliderMaxVal)
        addSubview(slider)
        addSubview(priceButton)
        addSubview(categoryButton)
        addSubview(collectionView)
        setSliderConstraints()
        setSliderMinValConstraints()
        setSliderMaxValConstraints()
        setPriceButtonConstraints()
        setCategoryButtonConstraints()
        setCollectionViewViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSliderMinValConstraints() {
        sliderMinVal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderMinVal.topAnchor.constraint(equalTo: slider.topAnchor, constant: -15),
            sliderMinVal.leadingAnchor.constraint(equalTo: slider.leadingAnchor)
        ])
    }
    
    private func setSliderMaxValConstraints() {
        sliderMaxVal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderMaxVal.topAnchor.constraint(equalTo: slider.topAnchor, constant: -20),
            sliderMaxVal.trailingAnchor.constraint(equalTo: slider.trailingAnchor)
        ])
    }
    
    private func setSliderConstraints() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
    
    private func setPriceButtonConstraints() {
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
            priceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceButton.widthAnchor.constraint(equalToConstant: 160),
            priceButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
        ])
    }
    
    private func setCategoryButtonConstraints() {
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
            categoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categoryButton.widthAnchor.constraint(equalToConstant: 160),
            categoryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
        ])
        
    }
    
    private func setCollectionViewViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: priceButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    

}
