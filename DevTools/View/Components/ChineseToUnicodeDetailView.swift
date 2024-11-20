//
//  ChineseToUnicodeDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/11/19.
//

import SwiftUI

struct ChineseToUnicodeDetailView: View {
    @State var inputText = ""
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        BaseConvertView(convertA: "Chinese", convertB: "Unicode", convertAtoB: {
            var res = ""
            for scalar in inputText.unicodeScalars {
                if scalar.isASCII {
                    res.append(String(scalar))
                } else {
                    res.append(String(format: "\\u%X", scalar.value))
                }
            }
            inputText = res
        }, convertBtoA: {
            let tempStr1 = inputText.replacingOccurrences(of: "\\u", with: "\\U")
            let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
            let tempStr3 = "\"".appending(tempStr2).appending("\"")
            let tempData = tempStr3.data(using: String.Encoding.utf8)
            var returnStr:String = ""
            do {
                returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
            } catch {
                alertMessage = "convert failed, error unicode"
                showAlert = true
            }
            inputText = returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
            
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    ChineseToUnicodeDetailView()
}
