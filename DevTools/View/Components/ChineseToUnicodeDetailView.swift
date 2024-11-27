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
            inputText = inputText.unicode()
        }, convertBtoA: {
            inputText = inputText.chinese() ?? {
                (alertMessage, showAlert) = ("convert failed, error unicode", true)
                return inputText
            }()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    ChineseToUnicodeDetailView()
}
