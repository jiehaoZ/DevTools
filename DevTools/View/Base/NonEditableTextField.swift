//
//  NonEditableTextField.swift
//  DevTools
//
//  Created by Karen on 2024/11/22.
//

import SwiftUI
import AppKit

struct NonEditableSelectableTextField: NSViewRepresentable {
    var text: String
    var isEditable: Bool
    
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.stringValue = text
        textField.isEditable = isEditable
        textField.isSelectable = true
        textField.backgroundColor = .clear
        textField.isBordered = true
        textField.drawsBackground = true
        textField.font = .boldSystemFont(ofSize: 25)
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
    }
}
