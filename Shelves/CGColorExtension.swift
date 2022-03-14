//
//  UIColorExtension.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 14.03.2022.
//

import UIKit

extension CGColor {
    static func colorFrom(hex: String) -> CGColor? {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        let rgb = UInt32(hex, radix: 16) ?? 0
        if hex.count == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if hex.count == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }
        return CGColor(red: r, green: g, blue: b, alpha: a)
    }
    
    static func hexFrom(color: CGColor) -> String? {
        guard let components = color.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if components.count >= 4 {
            let hex = String(format: "%02X%02X%02X%02X", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
            return hex
        } else {
            let hex = String(format: "%02X%02X%02X", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
            return hex
        }
    }
}
