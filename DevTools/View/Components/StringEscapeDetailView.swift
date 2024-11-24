//
//  StringEscapeDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/11/24.
//

import SwiftUI

struct StringEscapeDetailView: View {
    @State var inputText = ""
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        BaseConvertView(convertA: "String", convertB: "EscapedString", convertAtoB: {
            escapeString()
        }, convertBtoA: {
            descapeString()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
    
    func escapeString() {
        var escapedString =
        #"""
\#(inputText)
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
        
        inputText = escapedString
    }
    
    
    func descapeString() {
        var descapeString =
                #"""
\#(inputText)
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
        
        inputText = descapeString
    }
}

#Preview {
    StringEscapeDetailView()
}
