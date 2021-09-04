//
//  Theme.swift
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

import Foundation
import UIKit
var isLight = true
var currentThemeColor = isLight ? UIColor.white : UIColor.black
var otherThemeColor = isLight ? UIColor(hexString:"#3D4548") : UIColor(hexString: "#797F88")
var viewThemeColor = isLight ? UIColor.white : UIColor(hexString: "#262627")
extension String {
    var themed:String {
        let prefix =  isLight ? "Light" : "Dark"
        return prefix + self
    }
}
