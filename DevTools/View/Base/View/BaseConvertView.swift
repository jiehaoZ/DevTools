//
//  BaseConvertView.swift
//  DevTools
//
//  Created by Karen on 2024/11/19.
//

import SwiftUI
import CodeEditor

private enum ConvertState: Int, CaseIterable {
    case AToB = 1
    case BToA  = 2
}

struct BaseConvertView: View {
    @Binding var inputText: String
    // Alert
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    private var convertA = ""
    private var convertB = ""
    private let convertAtoB: () -> Void
    private let convertBtoA: () -> Void
    
    @State private var convertState: ConvertState = .AToB
    
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
            headerContent
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
    
    // MARK: UI
    private var headerContent: some View {
        HStack {
            Picker("", selection: $convertState) {
                ForEach(ConvertState.allCases, id: \.self) { state in
                    if state == .AToB {
                        Text("\(convertA)➡️\(convertB)")
                    } else {
                        Text("\(convertB)➡️\(convertA)")
                    }
                    
                }
            }
            .pickerStyle(MenuPickerStyle())
            .fixedSize()
            
            Spacer()
            
            Button(action: {
                onConvertClick()
            }, label: {
                Text("convert")
            })
        }
    }
    
    // content inputed
    private var stringContent: some View {
        CodeEditor(source: $inputText, language: .json, theme: .atelierSavannaDark, fontSize: Binding.constant(16))
            .cornerRadius(5)
    }
    
    // MARK: Actions
    private func onConvertClick() {
        if convertState == .AToB {
            self.convertAtoB()
        } else {
            self.convertBtoA()
        }
    }
}
