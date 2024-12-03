//
//  Playground.swift
//  DevTools
//
//  Created by Karen on 2024/11/23.
//

import SwiftUI
import AppKit

struct CustomTextView: NSViewRepresentable {
    @Binding var text: String
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeNSView(context: Context) -> NSScrollView {
        // 初始化 NSTextView
        let textView = NSTextView()
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isSelectable = true
        textView.font = NSFont.systemFont(ofSize: 14)
        textView.isRichText = false
        textView.usesAdaptiveColorMappingForDarkAppearance = true
        textView.drawsBackground = true
        textView.backgroundColor = .white
        // 禁用一些自动更正功能
        textView.isAutomaticSpellingCorrectionEnabled = false
        textView.isAutomaticTextReplacementEnabled = false
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false
        textView.isAutomaticLinkDetectionEnabled = false
        // 确保 textView 的文本内容会换行
        textView.isHorizontallyResizable = false
        textView.isVerticallyResizable = true
        textView.textContainer?.widthTracksTextView = true
        textView.textContainer?.containerSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        // 创建 NSScrollView 并将 textView 作为 documentView
        let scrollView = NSScrollView()
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        // 将内容设置到 scrollView 的边界
        scrollView.contentView.postsBoundsChangedNotifications = true
        scrollView.contentView.postsFrameChangedNotifications = true
        // 返回配置好的 scrollView
        return scrollView
    }
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let textView = nsView.documentView as? NSTextView {
            if textView.string != text {
                textView.string = text
            }
        }
    }
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CustomTextView
        init(_ parent: CustomTextView) {
            self.parent = parent
        }
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            DispatchQueue.main.async {
                self.parent.text = textView.string
            }
        }
    }
}
struct Playground: View {
    @State private var text = "请输入一些文字..."
    var body: some View {
        VStack {
//            CodeEditor(source: $text)
//                .frame(height: 200)
//                .padding()
//                .border(Color.gray)
            
            Text("输入内容：\(text)")
                .padding()
        }
        .padding()
    }
}


#Preview {
    Playground()
}


