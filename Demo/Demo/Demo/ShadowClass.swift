//
//  ShadowClass.swift
//  Demo
//
//  Created by fluper on 16/07/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func drawShadowwithCorner() {
           let layer = self.layer
           layer.shadowColor = #colorLiteral(red: 0.8466930389, green: 0.8466930389, blue: 0.8466930389, alpha: 1)
           layer.shadowOffset = CGSize(width: 0, height:0)
           layer.shadowOpacity = 1
           layer.shadowRadius = 5
           layer.cornerRadius = 20
        
       }
}
