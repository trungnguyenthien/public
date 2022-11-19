//
//  DesignableLabel.swift
//  MyApp
//
//  Created by Trung on 23/10/2022.
//

import Foundation
import UIKit

@IBDesignable
class DesignableLabel: UILabel {
    @IBInspectable var paddingTop: CGFloat = 0,
                       paddingBottom: CGFloat = 0,
                       paddingLeft: CGFloat = 0,
                       paddingRight: CGFloat = 0
    
    @IBInspectable var autoPadding: Bool = true
    @IBInspectable var zeroSizeIfHidden: Bool = true
    
    private var edgeInsets: UIEdgeInsets {
        if autoPadding {
            let half: Double = cornerRadius / 2.0
            return .init(
                top: half,
                left: half + 2,
                bottom: half,
                right: half + 2
            )
        } else {
            return .init(
                top: paddingTop,
                left: paddingLeft,
                bottom: paddingBottom,
                right: paddingRight
            )
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        if zeroSizeIfHidden, isHidden { return .zero }
        
        var size = super.intrinsicContentSize
        let edgeInsets = self.edgeInsets
        size.width += edgeInsets.left + edgeInsets.right
        size.height += edgeInsets.top + edgeInsets.bottom
        
        return size
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        performViewDraw()
        layer.masksToBounds = true
    }
}
