//
//  ViewController.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 30.3.23.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire


class CategoryListViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var categories = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        jsonDataCategory()
        configureNavTitle()
        setupNavigationButton()
    }
    
    func configureNavTitle(){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationItem.title = "Categories"
    }
    
    func setupNavigationButton() {
        let image = UIImage(named: "iconSearch2")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(yourButtonAction))
        navigationItem.rightBarButtonItem = button
    }

    @objc func yourButtonAction() {
        print("Your text to print")
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC,animated:true)
    }
                                                                   
    
    func setupViews(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        
        // layout.itemSize = CGSize(width: 200, height: 200)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemPink
        collectionView.register(CategoryMealCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .systemIndigo
        view.addSubview(collectionView)
    }

    
    
    func setupConstraints(){
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(90)
            make.bottom.equalTo(view).offset(-90)
            make.centerX.equalToSuperview()
            make.width.equalTo(view)
        }
    }
    
    
    // MARK: - Decodable
//    func jsonDataCategory(){
//        let urlString =  "https://www.themealdb.com/api/json/v1/1/categories.php"
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Error fetching categories: \(error.localizedDescription)")
//                return
//            }
//            guard let data = data else {return}
//
//            do {
//                let response = try JSONDecoder().decode(Categories.self, from: data)
//                self.categories = response.categories
//                DispatchQueue.main.async {
//                    self.collectionView?.reloadData()
//                    //print(self.categories.count)
//                }
//                //                    for category in response.categories{
//                //                        print(category)
//                //                    }
//            }
//            catch{
//                print("error")
//            }
//        }.resume()
//    }
    
    
    // MARK: - Alamofire
//    func jsonDataCategory() {
//            let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
//
//            AF.request(urlString)
//                .validate()
//                .responseDecodable(of: Categories.self) { response in
//                switch response.result {
//                case .success(let categories):
//                    self.categories = categories.categories
//                    DispatchQueue.main.async {
//                        self.collectionView?.reloadData()
//                    }
//                case .failure(let error):
//                    print("Error fetching categories: \(error.localizedDescription)")
//                }
//            }
//        }


    
    func jsonDataCategory() {
        MealsService.fetchCategoy{ result in
            switch result {
            case .success(let categories):
                if let safeCategories = categories.categories {
                    self.categories = safeCategories
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching categories: \(error.localizedDescription)")
            }
        }
    }



    
}

// MARK: - Delegate, DataSource and DelegateFlowLayout
extension CategoryListViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item \(indexPath.row)")
        
        let vc2 = MealCategoryListViewController(categoryName: categories[indexPath.row].titleCategory ?? "")
        navigationController?.pushViewController(vc2, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryMealCollectionViewCell
        cell.setupCell(with: categories[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-60, height: (view.frame.size.width/2)-60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 30, bottom: 10, right: 30)
    }
    
}
