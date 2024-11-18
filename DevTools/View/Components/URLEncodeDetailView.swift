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
            print("URLEncode")
        }, convertBtoA: {
            print("URLDecode")
        }, inputText: $inputText, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

#Preview {
    URLEncodeDetailView()
}
