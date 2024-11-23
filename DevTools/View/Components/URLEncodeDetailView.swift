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
        BaseConvertView(convertA: "URL", convertB: "EncodedURL", convertAtoB: {
            if let res = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                inputText = res
            } else {
                alertMessage = "URL encode failed, error url"
                showAlert = true
            }
        }, convertBtoA: {
            if let res = inputText.removingPercentEncoding {
                inputText = res
            } else {
                alertMessage = "URL decode failed, error url"
                showAlert = true
            }
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    URLEncodeDetailView()
}
