//
//  EmployeeDetailView.swift
//  employee-directory
//
//  Created by Ben Lee on 6/23/22.
//

import Kingfisher
import UIKit

class EmployeeDetailView: UIView {
    let container = UIStackView(alignment: .center,
                                axis: .vertical,
                                distribution: .equalCentering,
                                spacing: 10)
    
    var employeeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    var detailsContainer = UIStackView(alignment: .center, axis: .vertical, distribution: .equalSpacing, spacing: 10)
    
    let nameLabel = UILabel(font: .systemFont(ofSize: UIFont.systemFontSize))
    let teamLabel = UILabel(font: .systemFont(ofSize: UIFont.systemFontSize))
    lazy var phoneLabel = UILabel(font: .systemFont(ofSize: UIFont.systemFontSize))
    let emailLabel = UILabel(font: .systemFont(ofSize: UIFont.systemFontSize))
    lazy var biographyLabel = UILabel(numberOfLines: 0, font: .systemFont(ofSize: UIFont.systemFontSize))
    let employeeTypeLabel = UILabel(numberOfLines: 0, font: .systemFont(ofSize: UIFont.systemFontSize))
                                
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubviewAndFillSafeArea(container)
        container.addArrangedSubviews(employeeImage, detailsContainer)
        container.setDirectionalLayoutMargins(top: self.frame.height/10, leading: 0, bottom: self.frame.height/10, trailing: 0)
        detailsContainer.addArrangedSubviews(nameLabel, teamLabel, phoneLabel, emailLabel, biographyLabel, employeeTypeLabel)
    }
}

fileprivate extension UILabel {
    convenience init(numberOfLines: Int = 1, font: UIFont, textAlignment: NSTextAlignment = .center) {
        self.init()
        self.numberOfLines = numberOfLines
        self.font = font
        self.textAlignment = textAlignment
    }
}
