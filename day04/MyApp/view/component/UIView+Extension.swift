//
//  UIView+Extension.swift
//  MyApp
//
//  Created by Trung on 23/10/2022.
//

import Foundation
import UIKit

extension UIView {
    var isVisible: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
    
    func fitHeight(expectedWidth: CGFloat) -> CGFloat {
        setNeedsLayout()
        layoutIfNeeded()
        var targetSize = UIView.layoutFittingCompressedSize
        targetSize.width = expectedWidth
        return systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .defaultHigh,
            verticalFittingPriority: .defaultLow
        ).height
    }
}
