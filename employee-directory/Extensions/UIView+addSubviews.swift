//
//  UIView+addSubviews.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}
