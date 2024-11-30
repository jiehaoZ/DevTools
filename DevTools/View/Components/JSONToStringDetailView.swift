//
//  JSONToStringDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI
import SwiftyJSON

struct JSONToStringDetailView: View {
    @State var inputText = ""
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        BaseConvertView(convertA: "String", convertB: "JSON", convertAtoB: {
            convertStringToJson()
        }, convertBtoA: {
            convertJsonToString()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
    
    func convertJsonToString() {
        guard inputText.isValidJSON() else {
            self.showAlert = true
            self.alertMessage = "invalid JSON 123"
            return
        }
        if inputText.data(using: .utf8) != nil {
            let charactersToRemove = CharacterSet.whitespacesAndNewlines
            let res = "\"\(inputText.components(separatedBy: charactersToRemove).joined())\""
            inputText = res.chinese() ?? res
        } else {
            self.showAlert = true
            self.alertMessage = "invalid JSON"
        }
    }
    func convertStringToJson() {
        let str = inputText.removeWhitespaceCharacters().removeQuotes().deEscaped().unicode()
                
        if let data = str.data(using: .utf8) {
            do {
                // 尝试解析 JSON 数据（验证格式）
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                // 转换为格式化字符串
                let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let prettyPrintedString = String(data: prettyJsonData, encoding: .utf8) {
                    inputText = prettyPrintedString.chinese() ?? prettyPrintedString
                } else {
                    self.showAlert = true
                    self.alertMessage = "invalid JSON string"
                }
            } catch {
                self.showAlert = true
                self.alertMessage = "ERROR: \(error.localizedDescription)"
            }
        } else {
            self.showAlert = true
            self.alertMessage = "invalid JSON string"
        }
    }
}

#Preview {
    JSONToStringDetailView()
}
