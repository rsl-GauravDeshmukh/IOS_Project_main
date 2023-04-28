//
//  Cart.swift
//  MiniShoppingApp
//
//  Created by Gaurav Deshmukh on 11/04/23.
//

import Foundation

class Cart {
    var cartItems:[Products] = []
    
    static let shared = Cart(items: [])
    
    private init(items:[Products]) {
        cartItems = items
    }
}
