//
//  ToolTextEditor.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

struct ToolTextEditor: NSViewRepresentable {
    @Binding var text: String
    
    let fontSize: CGFloat = 14
    let textColor: NSColor = .white
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: ToolTextEditor
        init(parent: ToolTextEditor) {
            self.parent = parent
        }
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            self.parent.text = textView.string
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    func makeNSView(context: Context) -> NSScrollView {
        let textView = NSTextView()
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isSelectable = true
        textView.isRichText = false
        
        // 设置初始字体大小和颜色
        textView.font = NSFont.systemFont(ofSize: self.fontSize)
        textView.textColor = self.textColor
        let scrollView = NSScrollView()
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        
        return scrollView
    }
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        textView.string = text
        // 更新字体大小, 颜色和字体
        textView.font = NSFont.systemFont(ofSize: self.fontSize)
        textView.textColor = self.textColor
        
        
        if let textView = nsView.documentView as? NSTextView {
            if textView.string != text {
                textView.string = text
            }
        }
    }
}
