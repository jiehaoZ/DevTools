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
        BaseConvertView(convertA: "EscapedString", convertB: "String", convertAtoB: {
            inputText = inputText.deEscaped()
        }, convertBtoA: {
            inputText = inputText.escaped()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    StringEscapeDetailView()
}
