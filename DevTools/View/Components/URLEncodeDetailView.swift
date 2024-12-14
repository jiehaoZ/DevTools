//
//  URLEncodeDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/11/19.
//

import SwiftUI

struct URLEncodeDetailView: View {
    @State var inputText = ""
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        BaseConvertView(convertA: "EncodedURL", convertB: "URL", convertAtoB: {
            inputText = inputText.removingPercentEncoding ?? {
                (alertMessage, showAlert) = ("URL decode failed, error url", true)
                return inputText
            }()
        }, convertBtoA: {
            inputText = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? {
                (alertMessage, showAlert) = ("URL encode failed, error url", true)
                return inputText
            }()
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    URLEncodeDetailView()
}
