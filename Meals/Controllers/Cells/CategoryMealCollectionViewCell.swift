//
//  CollectionViewCell.swift
//  Meals
//
//  Created by Iskra Gjorgjievska on 30.3.23.
//

import UIKit

class CategoryMealCollectionViewCell: UICollectionViewCell {
    
    var imageViewCell: UIImageView!
    var imageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setupViews() {
        //contentView.backgroundColor = .green
        
        imageViewCell = UIImageView()
        
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.masksToBounds = true
        imageViewCell.layer.cornerRadius = 15
        imageViewCell.backgroundColor = .systemMint

        imageLabel = UILabel()
        imageLabel.backgroundColor = .lightGray
        imageLabel.shadowColor = .gray
        imageLabel.layer.shadowOffset = .zero
        imageLabel.layer.shadowOpacity = 1
        imageLabel.textAlignment = .center
       
        contentView.addSubview(imageViewCell)
        contentView.addSubview(imageLabel)
    }
    
    func setupConstraints() {
        imageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.left.right.equalTo(imageViewCell)
            make.height.equalTo(20)
            
        }
        imageViewCell.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(imageLabel.snp.top)
        }
    }
    
//    func setupConstraints() {
//        imageViewCell.snp.makeConstraints { make in
//            make.top.left.right.equalTo(contentView)
////            make.height.equalTo(130)
//            make.bottom.equalTo(imageLabel.snp.top)
//        }
//
//        imageLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(contentView)
//            make.left.right.equalTo(contentView)
//            make.top.equalTo(imageViewCell.snp.bottom)
//
//        }
//
//    }

    func setupCell(with category: Category) {
        guard let safeImageUrl = category.imageCategory, let safeCategoryName = category.titleCategory else { return }
        imageViewCell.kf.setImage(with: URL(string: safeImageUrl))
        imageLabel.text = safeCategoryName
        imageViewCell.contentMode = .scaleAspectFit
        //setImageContentMode(.scaleAspectFit)
        
    }
    
    func setupCell(with meal: Meal) {
        guard let safeImageUrl = meal.strMealThumb, let safeCategoryName = meal.strMeal else { return }
        imageViewCell.kf.setImage(with: URL(string: safeImageUrl))
        imageLabel.text = safeCategoryName
        imageViewCell.contentMode = .scaleAspectFill
        //setImageContentMode(.scaleToFill)
    }
    
}
