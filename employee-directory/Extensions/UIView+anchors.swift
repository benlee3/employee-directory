//
//  UIView+anchors.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import UIKit

extension UIView {
    func addSubviewAndFillSafeArea(_ subview: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        addSubviewAndAnchor(subview,
                     top: self.safeAreaLayoutGuide.topAnchor,
                     leading: self.safeAreaLayoutGuide.leadingAnchor,
                     bottom: self.safeAreaLayoutGuide.bottomAnchor,
                     trailing: self.safeAreaLayoutGuide.trailingAnchor,
                     padding: .init(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    // helper function to add a subview and have it "fill" the parent
    func addSubviewAndFill(_ subview: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        addSubviewAndAnchor(subview,
                     top: self.topAnchor,
                     leading: self.leadingAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.trailingAnchor,
                     padding: .init(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    // helper function to add a subview and anchor it with the given constraints
    func addSubviewAndAnchor(_ subview: UIView,
                             width: CGFloat? = nil,
                             height: CGFloat? = nil,
                             top: NSLayoutYAxisAnchor? = nil,
                             leading: NSLayoutXAxisAnchor? = nil,
                             bottom: NSLayoutYAxisAnchor? = nil,
                             trailing: NSLayoutXAxisAnchor? = nil,
                             centerX: NSLayoutXAxisAnchor? = nil,
                             centerY: NSLayoutYAxisAnchor? = nil,
                             padding: Padding = .init()) {
        addSubview(subview)
        subview.anchor(width: width, height: height, top: top, leading: leading, bottom: bottom, trailing: trailing, centerX: centerX, centerY: centerY, padding: padding)
    }
    
    // helper function to anchor a view with the given constraints
    func anchor(width: CGFloat? = nil,
                height: CGFloat? = nil,
                top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                padding: Padding = Padding()) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.leading).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.trailing).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: padding.centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: padding.centerY).isActive = true
        }
    }
}

struct Padding {
    var top: CGFloat = 0
    var leading: CGFloat = 0
    var bottom: CGFloat = 0
    var trailing: CGFloat = 0
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
}
