//
//  BaseConvertView.swift
//  DevTools
//
//  Created by Karen on 2024/11/19.
//

import SwiftUI
import CodeEditor

struct BaseConvertView: View {
    @Binding var inputText: String
    // Alert
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
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
            BaseConvertHeaderView(convertA: convertA, convertB: convertB) { state in
                onConvertClick(state: state)
            }
            stringContent
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
    private var stringContent: some View {
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
