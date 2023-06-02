//
//  SearchViewController.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 5.4.23.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class SearchViewController: UIViewController{
    
    var tableView: UITableView!
    var searchController: UISearchController!
    var meals = [Meal]()
    var filteredData = [Meal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .systemOrange
    }
    
    func setupViews(){
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SearchMealTableViewCell.self
                           , forCellReuseIdentifier: "tableViewCell")
        tableView.backgroundColor = .systemTeal
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 350
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Melas"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false //always to show search bar
        title = "Search"
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
    }
    
    func setupConstraints(){
        tableView.snp.makeConstraints { make in
            // make.edges.equalToSuperview()
            make.top.top.left.equalTo(view).offset(0)
            make.bottom.right.equalTo(view).offset(0)
            tableView.layer.cornerRadius = 10
            tableView.layer.masksToBounds = true
            
        }
    }
    
    // MARK: -  Decodable
    //    func searchMeals(with name: String?) {
    //        guard let searchedString = name else { return }
    //        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchedString)"
    //        guard let url = URL(string: urlString) else { return }
    //
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if let error = error {
    //                print("Error fetching meals: \(error.localizedDescription)")
    //                return
    //            }
    //            guard let data = data else { return }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                let response = try decoder.decode(Meals.self, from: data)
    //                self.meals = response.meals ?? [Meal]()
    //
    //                DispatchQueue.main.async {
    //                    self.tableView.reloadData()
    //                    print(self.meals.count)
    //                }
    //            } catch {
    //                print(error)
    //            }
    //        }.resume()
    //    }
    
    
    
    // MARK: -  Alamofire
//    func searchMeals(with name: String?) {
//        guard let searchedString = name else { return }
//        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchedString)"
//        AF.request(urlString)
//            .validate()
//            .responseDecodable(of: Meals.self){ (response) in
//                switch response.result {
//                case .success(let mealsResponse):
//                    self.meals = mealsResponse.meals ?? [Meal]()
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    print("Error fetching meals: \(error.localizedDescription)")
//
//                }
//            }
//    }
//
    
    
    func searchMeals(with name: String?) {
        guard let searchedString = name else { return }
        MealsService.fetchMealSearch(forSearchedString: searchedString){ result in
            switch result {
            case .success(let meals):
                if let safeMeal = meals.meals {
                    self.meals = safeMeal
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching searchMeals: \(error.localizedDescription)")
            }
        }
    }
}

//MARK: - UITableView Delegate & DataSource Methods -

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! SearchMealTableViewCell
        cell.setupCell(with: meals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - UISearchResultsUpdating methods
extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else { return }
    }
    
    
}

//MARK: - UISearchBarDelegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        searchMeals(with: searchBar.text)
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

}
