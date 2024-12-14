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
        BaseConvertView(convertA: "Unicode", convertB: "Chinese", convertAtoB: {
            inputText = inputText.chinese() ?? {
                (alertMessage, showAlert) = ("convert failed, error unicode", true)
                return inputText
            }()
        }, convertBtoA: {
            inputText = inputText.unicode()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    ChineseToUnicodeDetailView()
}
