//
//  EmployeeListCell.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import Kingfisher
import UIKit

class EmployeeListCell: UICollectionViewCell {
    let container: UIStackView = {
        let stack = UIStackView(alignment: .center, axis: .vertical, distribution: .equalCentering, spacing: 10)
        stack.setDirectionalLayoutMargins(top: 10, leading: 10, bottom: 10, trailing: 10)
        return stack
    }()
    
    let infoStack: UIStackView = {
        let stack = UIStackView(alignment: .fill, axis: .vertical, distribution: .equalCentering)
        return stack
    }()
    
    let employeeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupCell(employee: Employee) {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 16
        self.addSubviewAndAnchor(container,
                                 centerX: self.centerXAnchor,
                                 centerY: self.centerYAnchor)
        container.addArrangedSubviews(employeeImage, infoStack)
        infoStack.addArrangedSubviews(nameLabel, teamLabel)
        infoStack.anchor(width: self.contentView.frame.size.width * 0.75)
        self.nameLabel.text = employee.fullName
        self.teamLabel.text = employee.team
    }
    
    func retrieveImage(for url: String) {
        self.employeeImage.kf.indicatorType = .activity
        let roundedCornerProcessor = RoundCornerImageProcessor(cornerRadius: 100, backgroundColor: .lightGray)
        let diameter = self.contentView.frame.size.width * 0.40
        self.employeeImage.anchor(width: diameter, height: diameter)
        self.employeeImage.kf.setImage(with: URL(string: url), options: [ .processor(roundedCornerProcessor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//struct ViewRepresentable: UIViewRepresentable {
//    func makeUIView(context: Context) -> some UIView {
//        let cell = EmployeeCell()
//        cell.setupCell(employee: Employee(id: "test", fullName: "Ben Lee", phoneNumber: nil, emailAddress: "", biography: nil, photoURLSmall: nil, photoURLLarge: nil, team: "The NFZ", employee: .fullTime))
//        cell.anchor(width: 1000)
//        return cell
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) { }
//}
//
//@available(iOS 13.0, *)
//struct Controller_Preview: PreviewProvider {
//    static var previews: some View {
//        ViewRepresentable()
//    }
//}
//#endif
