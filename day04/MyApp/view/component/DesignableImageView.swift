//
//  DesignableImageView.swift
//  MyApp
//
//  Created by Trung on 23/10/2022.
//

import Foundation
import UIKit

@IBDesignable
class DesignableImageView: UIImageView {
    
    @IBInspectable var widthOfFlexHeight: CGFloat = 0
    @IBInspectable var heightOfFlexWidth: CGFloat = 0
    @IBInspectable var zeroSizeIfHidden: Bool = true
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        performViewDraw()
    }
    
    override var intrinsicContentSize: CGSize {
        if zeroSizeIfHidden, isHidden {
            return .zero
        }
        
        let realSize = image?.size ?? .zero
        
        if widthOfFlexHeight <= 0, heightOfFlexWidth <= 0 {
            return super.intrinsicContentSize
        } else if widthOfFlexHeight > 0, heightOfFlexWidth > 0 {
            return .init(width: widthOfFlexHeight, height: heightOfFlexWidth)
        } else if widthOfFlexHeight > 0 {
            let height = widthOfFlexHeight * realSize.height / realSize.width
            return .init(width: widthOfFlexHeight, height: height)
        } else {
            let width = heightOfFlexWidth * realSize.width / realSize.height
            return .init(width: width, height: heightOfFlexWidth)
        }
    }
}
