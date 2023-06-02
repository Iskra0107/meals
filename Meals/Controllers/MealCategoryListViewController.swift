//
//  ViewController2.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 31.3.23.
//

import UIKit
import SnapKit
import Alamofire

class MealCategoryListViewController: UIViewController {
    
    var collectionView2: UICollectionView!
    var imageView2: UIImageView!
    var imageLabel2: UILabel!
    var categoryName: String!
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        jsonDataMeal()
        view.backgroundColor = .systemIndigo
        // Do any additional setup after loading the view.
    }
    
    init(categoryName: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.categoryName = categoryName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.minimumLineSpacing = 10
        //layout.minimumInteritemSpacing = 5
        
        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView2.register(CategoryMealCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.backgroundColor = .systemPink
        
        view.addSubview(collectionView2)
    }
    
    func setUpConstraints(){
        collectionView2.snp.makeConstraints { make in
            make.top.equalTo(view).offset(90)
            make.bottom.equalTo(view).offset(-90)
            make.width.equalTo(view)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Json with Decodable
//    func jsonDataMeal() {
//        guard let safeCategoryName = categoryName else { return }
//            let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(safeCategoryName)"
//            guard let url = URL(string: urlString) else { return }
//
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    print("Error fetching meals: \(error.localizedDescription)")
//                    return
//                }
//                guard let data = data else { return }
//
//                do {
//                    let response = try JSONDecoder().decode(Meals.self, from: data)
//                    self.meals = response.meals ?? [Meal]()
//                    DispatchQueue.main.async {
//                        self.collectionView2.reloadData()
//                         //print(self.meals.count)
//                    }
////                    for meal in response.meals {
////                        print(meal)
////                    }
//                } catch {
//                    print("error")
//                }
//            }.resume()
//        }
    
    // MARK: - Json with Decodable and AF
//    func jsonDataMeal() {
//        guard let safeCategoryName = categoryName else { return }
//        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(safeCategoryName)"
//
//        AF.request(urlString).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let response = try JSONDecoder().decode(Meals.self, from: data)
//                    self.meals = response.meals ?? [Meal]()
//                    DispatchQueue.main.async {
//                        self.collectionView2.reloadData()
//                    }
//                } catch {
//                    print("Error decoding meals: \(error.localizedDescription)")
//                }
//            case .failure(let error):
//                print("Error fetching meals: \(error.localizedDescription)")
//            }
//        }
//    }
    
// MARK: - Json with AlamoFire
//    func jsonDataMeal() {
//        guard let safeCategoryName = categoryName else { return }
//        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(safeCategoryName)"
//        guard let url = URL(string: urlString) else { return }
//
//
//        AF.request(url).validate().responseDecodable(of: Meals.self) { (response) in
//            switch response.result {
//            case .success(let mealsResponse):
//                self.meals = mealsResponse.meals ?? [Meal]()
//                DispatchQueue.main.async {
//                    self.collectionView2.reloadData()
//                }
//            case .failure(let error):
//                print("Error fetching meals: \(error.localizedDescription)")
//            }
//        }
//    }
    
    
    func jsonDataMeal() {
        guard let safeCategoryName = categoryName else { return }
        MealsService.fetchMeals(forCategoryName: safeCategoryName) { result in
            switch result {
            case .success(let meals):
               // guard let safeMeal = meals.meals else { return }
                if let safeMeal = meals.meals {
                    self.meals = safeMeal
                }
               // self.meals = safeMeal
                DispatchQueue.main.async {
                    self.collectionView2.reloadData()
                }
            case .failure(let error):
                print("Error fetching meals: \(error.localizedDescription)")
            }
        }
    }
}



// MARK: - Delegate2 , DataSource2 and DelegateFlowLayout 2
extension MealCategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CategoryMealCollectionViewCell
        cell.setupCell(with: meals[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width)/3 - 20, height: (view.frame.size.width)/3 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10)
     }
    
    
}
