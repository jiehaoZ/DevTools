//
//  Playground.swift
//  DevTools
//
//  Created by Karen on 2024/11/23.
//

import SwiftUI

import SwiftUI
import AppKit
struct CustomTextField: NSViewRepresentable {
    @Binding var text: String
    class Coordinator: NSObject, NSTextFieldDelegate {
        var parent: CustomTextField
        init(_ parent: CustomTextField) {
            self.parent = parent
        }
        func controlTextDidChange(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField else {
                return
            }
            DispatchQueue.main.async {
                self.parent.text = textField.stringValue
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.delegate = context.coordinator
        textField.isEditable = true // Ensure the text field is editable
        return textField
    }
    func updateNSView(_ nsView: NSTextField, context: Context) {
        if nsView.stringValue != text {
            nsView.stringValue = text
        }
    }
}
struct Playground: View {
    @State private var text = "Hello, world!"
    var body: some View {
        VStack {
            CustomTextField(text: $text)
                .frame(width: 200, height: 30)
            Text("You typed: \(text)")
        }
        .padding()
    }
}

#Preview {
    Playground()
}
