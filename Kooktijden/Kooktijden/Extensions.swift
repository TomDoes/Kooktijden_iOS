//
//  Extensions.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 8/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

// Extended String with subscript
// usage "string"[index] returns character at index
extension String {
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
}