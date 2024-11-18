//
//  JSONToStringDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI
import SwiftyJSON

enum ConvertState {
    case jsonToString
    case stringToJson
}

struct JSONToStringDetailView: View {
    @State private var inputText: String = ""
    @State private var convertState: ConvertState = .jsonToString
    
    // Alert
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            headerContent
            stringContent
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(""),
                message: Text(alertMessage),
                dismissButton: .default(Text("确定"))
            )
        }
    }
    
    // MARK: UI
    // 标题内容
    var headerContent: some View {
        HStack {
            Text(convertState == .jsonToString ? "JSON" : "String")
                .font(.title)
            Image(systemName: "arrow.forward.circle")
                .font(.title2)
                .onTapGesture {
                    if convertState == .jsonToString {
                        convertState = .stringToJson
                    } else {
                        convertState = .jsonToString
                    }
                }
            Text(convertState == .jsonToString ? "String" : "JSON")
                .font(.title)
            
            Spacer()
            
            Button(action: {
                onConvertClick()
            }, label: {
                Text("convert")
            })
        }
    }
    
    // 输入的文本
    var stringContent: some View {
        TextEditor(text: $inputText)
            .cornerRadius(10)
            .font(.title3)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .opacity(0.4)
            )
            .autocorrectionDisabled(true)
    }
    
    // MARK: actions
    func onConvertClick() {
        if convertState == .jsonToString {
            self.convertJsonToString()
        } else {
            self.convertStringToJson()
        }
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
    
    func showAlert(text: String) {
        let alert = NSAlert()
        alert.messageText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "确定")
        alert.runModal()
    }
}

#Preview {
    JSONToStringDetailView()
}
