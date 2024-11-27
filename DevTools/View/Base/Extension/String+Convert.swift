//
//  String+Convert.swift
//  DevTools
//
//  Created by Karen on 2024/11/27.
//

import Foundation

extension String {
    func removeQuotes() -> Self {
        var result = self
        // check prefix " and '
        if result.hasPrefix("\"") || result.hasPrefix("\'") {
            result.removeFirst()
        }
        
        // check suffix " and '
        if result.hasSuffix("\"") || result.hasSuffix("\'") {
            result.removeLast()
        }
        
        return result
    }
    
    // escape
    func escaped() -> Self {
        var escapedString =
        #"""
\#(self)
"""#
        let escapeCharacters = [
            ("\\", "\\\\"),
            ("\"", "\\\""),
            ("\n", "\\n"),
            ("\r", "\\r"),
            ("\t", "\\t"),
            ("\'", "\\'"),
        ]
        
        for (original, replacement) in escapeCharacters {
            escapedString = escapedString.replacingOccurrences(of: original, with: replacement)
        }
        
        return escapedString;
    }
    func deEscaped() -> Self {
        var descapeString =
                #"""
\#(self)
"""#
        let replacements = [
            ( "\\\\", "\\"),
            ("\\\"", "\""),
            ("\\n", "\n"),
            ("\\r", "\r"),
            ("\\t", "\t"),
            ("\\'", "\'"),
        ]
        
        for (original, replacement) in replacements {
            descapeString = descapeString.replacingOccurrences(of: original, with: replacement)
        }
        
        return descapeString
    }
    
    // unicode
    func unicode() -> String {
        var result = ""
        for scalar in self.unicodeScalars {
            if scalar.isASCII {
                result.append(String(scalar))
            } else {
                result.append(String(format: "\\u%X", scalar.value))
            }
        }
        return result
    }
    func chinese() -> String? {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            return nil;
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}
