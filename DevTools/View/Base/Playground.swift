//
//  Playground.swift
//  DevTools
//
//  Created by Karen on 2024/11/23.
//

import AppKit
import SwiftUI
import CoreImage.CIFilterBuiltins

struct Playground: View {
    let originalString = #"""
{"age":15,"gender":"man","height":"140cm","name":"王五"}
"""#
    
    
    var body: some View {
        VStack {
            Text(originalString.escaped())
        }
        .padding()
    }
}
extension String {
    func escaped() -> String {
        let escapeCharacters = [
            ("\\", "\\\\"), // 反斜杠必须最先替换，否则会干扰其他字符
            ("\"", "\\\""),
            ("\n", "\\n"),
            ("\r", "\\r"),
            ("\t", "\\t"),
            ("\'", "\\'"),
        ]
        
        var escapedString = self
        for (character, escapedCharacter) in escapeCharacters {
            escapedString = escapedString.replacingOccurrences(of: character, with: escapedCharacter)
        }
        
        return escapedString
    }
}

#Preview {
    Playground()
}
