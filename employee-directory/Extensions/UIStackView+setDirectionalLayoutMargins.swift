//
//  UIStackView+setDirectionalLayoutMargins.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import UIKit

extension UIStackView {
    func setDirectionalLayoutMargins(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
