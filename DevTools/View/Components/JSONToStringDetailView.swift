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
        BaseConvertView(convertA: "JSON", convertB: "String", convertAtoB: {
            convertJsonToString()
        }, convertBtoA: {
            convertStringToJson()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
    
    func convertJsonToString() {
        // ZJHTODO: 前置判断是否为 JSON
        if inputText.data(using: .utf8) != nil {
            let charactersToRemove = CharacterSet.whitespacesAndNewlines
            let res = inputText.components(separatedBy: charactersToRemove).joined()
            inputText = "\'\(res)\'"
        } else {
            self.showAlert = true
            self.alertMessage = "无效的 JSON 字符串"
        }
    }
    func convertStringToJson() {
        let str = removeQuotes(from: inputText)
                
        if let data = str.data(using: .utf8) {
            do {
                // 尝试解析 JSON 数据（验证格式）
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                // 转换为格式化字符串
                let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let prettyPrintedString = String(data: prettyJsonData, encoding: .utf8) {
                    inputText = prettyPrintedString
                } else {
                    self.showAlert = true
                    self.alertMessage = "无法转换成字符串"

                }
            } catch {
                self.showAlert = true
                self.alertMessage = "String 解析错误: \(error.localizedDescription)"
            }
        } else {
            self.showAlert = true
            self.alertMessage = "无效的字符串"
        }
    }
    
    func removeQuotes(from input: String) -> String {
        var result = input
        
        // 检查是否以双引号开头
        if result.hasPrefix("\"") || result.hasPrefix("\'") {
            // 移除开头的双引号
            result.removeFirst()
        }
        
        // 检查是否以双引号结尾
        if result.hasSuffix("\"") || result.hasSuffix("\'") {
            // 移除结尾的双引号
            result.removeLast()
        }
        
        return result
    }
}

#Preview {
    JSONToStringDetailView()
}
