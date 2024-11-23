//
//  NonEditableTextField.swift
//  DevTools
//
//  Created by Karen on 2024/11/22.
//

import SwiftUI
import AppKit

struct NonEditableSelectableTextField: NSViewRepresentable {
    @Binding var text: String
    var placeholder: String?
    var isEditable: Bool
    
    class Coordinator: NSObject, NSTextFieldDelegate {
        var parent: NonEditableSelectableTextField
        init(_ parent: NonEditableSelectableTextField) {
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
        textField.stringValue = text
        textField.placeholderString = placeholder ?? "input..."
        textField.isEditable = isEditable
        textField.isSelectable = true
        textField.backgroundColor = .clear
        textField.isBordered = true
        textField.drawsBackground = true
        textField.font = .boldSystemFont(ofSize: 20)
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
    }
}
