//
//  Constants.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 13.4.23.
//

import Foundation


struct Constants {
    
    static let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    struct Endopoints {
        //CategoryList
        static let mealsCategoriesList = baseURL + "/categories.php"
        //MealCategory
        static let mealsCategoryName = baseURL + "/filter.php?c=%@"
        //SearchView
        static let mealsSearch = baseURL + "/search.php?s=%@"
    }
    
}
