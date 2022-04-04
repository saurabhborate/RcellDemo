//
//  CommonUIHelper.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 03/04/22.
//

import Foundation
import UIKit

    @IBDesignable
    class DesignableButton: UIButton {
        @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }
       
    }
    

