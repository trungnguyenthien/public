//
//  DesignableView.swift
//  MyApp
//
//  Created by Trung on 23/10/2022.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
       set { layer.borderWidth = newValue }
       get { layer.borderWidth }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
    }
    
    func performViewDraw() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        layoutIfNeeded()
    }
}
