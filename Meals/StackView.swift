import UIKit
import SnapKit

class StackView: UIView {
    
    var ingrediantLabel: UILabel!
    var measureLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .gray
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        ingrediantLabel = UILabel()
        ingrediantLabel.textAlignment = .left
        ingrediantLabel.textColor = .black
        ingrediantLabel.numberOfLines = 0
        
        measureLabel = UILabel()
        measureLabel.textAlignment = .right
        measureLabel.textColor = .black
        measureLabel.numberOfLines = 0
        
        addSubview(ingrediantLabel)
        addSubview(measureLabel)
    }
    
    func setupConstraints(){
        ingrediantLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalTo(self.snp.centerX)
        }
        
        measureLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(ingrediantLabel)
            make.left.equalTo(self.snp.centerX)
        }
    }
    
    func setupView(ingrediantLabelText: String, measureLabelText: String) {
        ingrediantLabel.text = ingrediantLabelText + "-   "
        measureLabel.text = measureLabelText
    }
}
