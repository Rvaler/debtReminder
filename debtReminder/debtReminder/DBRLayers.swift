//
//  DBRLayers.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/23/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import Foundation
import UIKit

class DBRLayers:NSObject
{
    
    // create an underline textField
    static func DBRcreateUnderline(textField: UITextField, color: UIColor) -> CALayer
    {
        
        var bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, textField.frame.size.height - 1, textField.frame.size.width, 0.6)
        bottomBorder.backgroundColor = color.CGColor
        textField.layer.addSublayer(bottomBorder)
        
        return bottomBorder
    }
    
}