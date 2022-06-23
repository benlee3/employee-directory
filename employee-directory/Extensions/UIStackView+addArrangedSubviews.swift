//
//  UIStackView+addArrangedSubviews.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addArrangedSubview(subview)
        }
    }
}
