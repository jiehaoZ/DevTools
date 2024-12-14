//
//  BaseConvertView.swift
//  DevTools
//
//  Created by Karen on 2024/11/19.
//

import SwiftUI
import CodeEditor

struct BaseConvertView: View {
    @Binding private var inputText: String
    @State private var convertState: ConvertState = .AToB
    // Alert
    @Binding private var showAlert: Bool
    @Binding private var alertMessage: String
    
    private var convertA = ""
    private var convertB = ""
    private let convertAtoB: () -> Void
    private let convertBtoA: () -> Void
    
    init(convertA: String,
         convertB: String,
         convertAtoB: @escaping () -> Void,
         convertBtoA: @escaping () -> Void,
         inputText: Binding<String>,
         showAlert: Binding<Bool>,
         alertMessage: Binding<String>) {
        self.convertA = convertA
        self.convertB = convertB
        self.convertAtoB = convertAtoB
        self.convertBtoA = convertBtoA
        _inputText = inputText
        _showAlert = showAlert
        _alertMessage = alertMessage
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            BaseConvertHeaderView(convertA: convertA,
                                  convertB: convertB,
                                  convertState: $convertState) { state in
                onConvertClick(state: state)
            }
            Spacer().frame(height: 15)
            contentEditor
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(""),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    // content inputed
    private var contentEditor: some View {
        CodeEditor(source: $inputText, language: .json, theme: .atelierSavannaDark, fontSize: Binding.constant(16))
            .cornerRadius(5)
    }
    
    // MARK: Actions
    private func onConvertClick(state: ConvertState) {
        if state == .AToB {
            self.convertAtoB()
        } else {
            self.convertBtoA()
        }
    }
}
