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
    
    class func kooktijdenPinkColor() -> UIColor {
        return UIColor(red: 245.0/255.0, green: 0.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    
    class func listColor0() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    }
    
    class func listColor1() -> UIColor {
        return UIColor(red: 233.0/255.0, green: 30.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    }
    
    class func listColor2() -> UIColor {
        return UIColor(red: 156/255.0, green: 39.0/255.0, blue: 176.0/255.0, alpha: 1.0)
    }
    
    class func listColor3() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 152.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

}
