//
//  MealsService.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 12.4.23.
//

import Foundation
import Alamofire

struct MealsService {
    
    // MARK: -  fetchMeals - for MealCategoryListViewController
    static func fetchMeals(forCategoryName categoryName: String, completion: @escaping (Result<Meals, AFError>) -> Void) {
        let urlString = String(format: Constants.Endopoints.mealsCategoryName, categoryName)
        guard let url = URL(string: urlString) else {
            completion(.failure(AFError.invalidURL(url: urlString)))
            return
        }
        AF.request(url).validate().responseDecodable(of: Meals.self) { (response) in
            completion(response.result)
        }
    }
    
    
    // MARK: -  fetchMealSearch - for SearchViewController
    static func fetchMealSearch(forSearchedString searchedString: String, completion: @escaping (Result<Meals, AFError>) -> Void){
        let urlString = String(format: Constants.Endopoints.mealsSearch, searchedString)
        guard let url = URL(string:  urlString) else{
            completion(.failure(AFError.invalidURL(url: urlString)))
            return
        }
        AF.request(url).validate().responseDecodable(of: Meals.self) { (response) in
            completion(response.result)
        }
    }
    
    
    // MARK: -  fetchMealSearch - for CategoryListViewController
    static func fetchCategoy(completion: @escaping (Result<Categories, AFError>) -> Void) {
        let urlString = Constants.Endopoints.mealsCategoriesList
        guard let url = URL(string: urlString) else {
            completion(.failure(AFError.invalidURL(url: urlString)))
            return
        }
        AF.request(url).validate().responseDecodable(of: Categories.self) { (response) in
            completion(response.result)
        }
    }
    
}
