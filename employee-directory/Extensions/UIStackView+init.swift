//
//  UIStackView+init.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import UIKit

extension UIStackView {
    convenience init(alignment: UIStackView.Alignment? = nil,
                     axis: NSLayoutConstraint.Axis? = nil,
                     isBaselineRelativeArrangement: Bool? = nil,
                     distribution: UIStackView.Distribution? = nil,
                     margins: NSDirectionalEdgeInsets? = nil,
                     spacing: CGFloat? = nil,
                     backgroundColor: UIColor? = nil) {
        self.init()
        
        if let alignment = alignment {
            self.alignment = alignment
        }
        
        if let axis = axis {
            self.axis = axis
        }
        
        if let isBaselineRelativeArrangement = isBaselineRelativeArrangement {
            self.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        }
        
        if let distribution = distribution {
            self.distribution = distribution
        }
        
        if let margins = margins {
            self.isLayoutMarginsRelativeArrangement = true
            self.directionalLayoutMargins = margins
        }
        
        if let spacing = spacing {
            self.spacing = spacing
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}
