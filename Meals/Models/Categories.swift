//
//  Categories.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 31.3.23.
//

import Foundation


// MARK: - Categories
struct Categories: Codable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let idCategory: String?
    let titleCategory: String?
    let imageCategory: String?
    let descriptionCategory: String?
    let instructionsCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case idCategory
        case titleCategory = "strCategory"
        case imageCategory = "strCategoryThumb"
        case descriptionCategory = "strCategoryDescription"
        case instructionsCategory = "strInstructions"
    }
}







