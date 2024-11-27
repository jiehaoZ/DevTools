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
            inputText = inputText.escaped()
        }, convertBtoA: {
            inputText = inputText.deEscaped()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    StringEscapeDetailView()
}
