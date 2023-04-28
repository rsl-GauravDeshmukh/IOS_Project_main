//
//  Product.swift
//  MiniShoppingApp
//
//  Created by Gaurav Deshmukh on 11/04/23.
//

import Foundation
import UIKit
struct Products: Codable {
    let title:String
    let description:String
    let price:Double
    let category:String
    let thumbnail:String
}
