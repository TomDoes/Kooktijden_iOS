//
//  Extensions.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 8/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

// Extended String with subscript
// usage "string"[index] returns character at index
import UIKit


extension String {
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
}

extension UIColor {
    class func kooktijdenGreenColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    }
}