//
//  Color+Convert.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import Foundation
import SwiftUICore

extension Color {
    init?(hex: String) {
        let r, g, b, a: Double
        var hexColor = hex
        
        // remove prefix #
        if hexColor.hasPrefix("#") {
            hexColor = String(hexColor.dropFirst())
        }
        
        // handle different situations according to the length of the string
        switch hexColor.count {
        case 6: // RGB (with Alpha)
            guard let rgb = Int(hexColor, radix: 16) else { return nil }
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >> 8) & 0xFF) / 255.0
            b = Double(rgb & 0xFF) / 255.0
            a = 1.0
        case 8: // RGBA (without Alpha)
            guard let rgba = Int(hexColor, radix: 16) else { return nil }
            r = Double((rgba >> 24) & 0xFF) / 255.0
            g = Double((rgba >> 16) & 0xFF) / 255.0
            b = Double((rgba >> 8) & 0xFF) / 255.0
            a = Double(rgba & 0xFF) / 255.0
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    func toHexString() -> String? {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return nil
        }
        
        let r = components[0]
        let g = components[1]
        let b = components[2]
        
        // if contains alpha
        let a: CGFloat = components.count >= 4 ? components[3] : 1.0
        
        // with alpha
        let rgbHex = String(format: "#%02lX%02lX%02lX", lround(Double(r * 255)), lround(Double(g * 255)), lround(Double(b * 255)))
        
        // without alpha
        let rgbaHex = String(format: "#%02lX%02lX%02lX%02lX", lround(Double(r * 255)), lround(Double(g * 255)), lround(Double(b * 255)), lround(Double(a * 255)))
        
        return a == 1.0 ? rgbHex : rgbaHex
    }
    
    func getRGBAComponents() -> (r: Int, g: Int, b: Int, a: String)? {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return nil
        }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        let a = components.count >= 4 ? components[3] : 1.0
        
        return (r: r, g: g, b: b, a: String(format: "%.2f", a))
    }
}
