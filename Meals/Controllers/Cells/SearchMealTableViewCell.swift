//
//  SearchViewControllerTableViewCell.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 5.4.23.
//

import UIKit

class SearchMealTableViewCell: UITableViewCell {
    
    var customImageView: UIImageView!
    var titleLabel : UILabel!
    var categoryLabel : UILabel!
    var instructionLabel : UILabel!
    var ingredientLabel : UILabel!
    var ingredientsView: StackView!
    var stackView : UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
        
        customImageView = UIImageView()
//        customImageView.backgroundColor = .yellow
        customImageView.layer.cornerRadius = 10
        customImageView.clipsToBounds = true
        customImageView.layer.masksToBounds = true
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = .systemPink
        titleLabel.layer.cornerRadius = 3.0
        titleLabel.clipsToBounds = true
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center
        
        
        categoryLabel = UILabel()
        categoryLabel.numberOfLines = 0
        categoryLabel.adjustsFontSizeToFitWidth = true
//        categoryLabel.backgroundColor = .red
        categoryLabel.layer.cornerRadius = 3.0
        categoryLabel.clipsToBounds = true
        categoryLabel.font = UIFont.systemFont(ofSize: 20)
        categoryLabel.textAlignment = .center
        
        instructionLabel = UILabel()
        instructionLabel.numberOfLines = 0
        instructionLabel.adjustsFontSizeToFitWidth = true
        instructionLabel.backgroundColor = .systemGray6
        instructionLabel.layer.cornerRadius = 3.0
        instructionLabel.font = UIFont.systemFont(ofSize: 14)
        instructionLabel.clipsToBounds = true
        
//
//        ingredientLabel = UILabel()
//        ingredientLabel.numberOfLines = 0
//        ingredientLabel.adjustsFontSizeToFitWidth = false
//        ingredientLabel.lineBreakMode = .byTruncatingTail
////        ingredientLabel.backgroundColor = .blue
//        ingredientLabel.textAlignment = .left
//        ingredientLabel.layer.cornerRadius = 3.0
//        ingredientLabel.clipsToBounds = true
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        let lightPinkColor = UIColor(red: 255/255, green: 204/255, blue: 214/255, alpha: 2.0)
        stackView.backgroundColor = lightPinkColor
        
        
        contentView.addSubview(customImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(instructionLabel)
//        contentView.addSubview(ingredientLabel)
//        contentView.addSubview(ingredientsView)
        contentView.addSubview(stackView)
        
    }
    
    func setupConstraints(){
        
        customImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.height.width.equalTo(150)
            make.top.equalTo(contentView).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(customImageView.snp.bottom).offset(15)

        }
        
        categoryLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
//        ingredientsView.snp.makeConstraints { make in
////            make.top.equalTo(instructionLabel.snp.bottom).offset(20)
////            make.bottom.equalTo(contentView)
//            make.width.equalTo(contentView)
//            make.height.equalTo(50)
//        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(10)
//            make.width.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
        }
        
//        ingredientLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(contentView)
//           // make.width.equalTo(contentView)
//            make.top.equalTo(ingredientsView.snp.bottom).offset(10)
//            make.left.equalTo(contentView).offset(10)
//            make.right.equalTo(contentView).offset(-10)
//        }
//
        
    }
    
    func setupCell(with meal: Meal) {
        titleLabel.text = meal.strMeal
        categoryLabel.text = meal.strCategory
        instructionLabel.text = meal.strInstructions
        
        guard let safeImageUrl = meal.strMealThumb else {return}
        customImageView.kf.setImage(with: URL(string: safeImageUrl))
        
        let data = handleMealIngredients(meal: meal)
         
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        for i in 0..<min(20, data[0].count, data[1].count) {
            ingredientsView = StackView()
            ingredientsView.setupView(ingrediantLabelText: data[0][i], measureLabelText: data[1][i])
            stackView.addArrangedSubview(ingredientsView)
        }
       
    }
    
    func handleMealIngredients(meal: Meal) -> [[String]] {
    //  var concanatedString = ""
    //        concanatedString += "Indgridint: \(meal.strIngredient1 ?? "") \t Mesures: \(meal.strMeasure1 ?? "")"
        
        let mirror = Mirror(reflecting: meal)
        var ingredients = [String]()
        var measures = [String]()
        
        for i in 1...20 {
               let ingredientKey = "strIngredient\(i)"
               let measureKey = "strMeasure\(i)"
               let ingredient = mirror.children.first(where: { $0.label == ingredientKey })?.value as? String ?? ""
               let measure = mirror.children.first(where: { $0.label == measureKey })?.value as? String ?? ""
               
               if !ingredient.isEmpty && !measure.isEmpty {
                   ingredients.append(ingredient)
                   measures.append(measure)
               } else {
                   break
               }
           }
        return [ingredients , measures]
        
        //print("Ova e stringot:\n \(concanatedString)")
           // ingredientsView = concanatedString
        
        //let ingredientList = zip(ingredients, measures).map { "\($0) \($1)" }
        
    }
}
