//
//  SwiftUIView.swift
//  DevTools
//
//  Created by Karen on 2024/12/3.
//


import SwiftUI
import AppKit

struct PureTextView: NSViewRepresentable {
    @Binding var text: String
    var font: NSFont? = NSFont.systemFont(ofSize: 14)
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: PureTextView
        init(_ parent: PureTextView) {
            self.parent = parent
        }
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            DispatchQueue.main.async {
                self.parent.text = textView.string
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
    
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isSelectable = true
        textView.font = font
        textView.isRichText = false
        textView.usesAdaptiveColorMappingForDarkAppearance = true
        textView.drawsBackground = true
        textView.textContainerInset = CGSize(width: 5, height: 5)
        
        // disable smart punctuation, auto-correction etc
        textView.isAutomaticSpellingCorrectionEnabled = false
        textView.isAutomaticTextReplacementEnabled = false
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false
        textView.isAutomaticLinkDetectionEnabled = false
        
        let scrollView = NSScrollView()
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = false
        scrollView.borderType = .noBorder
        
        textView.minSize = NSSize(width: 0, height: 0)
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.textContainer?.widthTracksTextView = true
        textView.textContainer?.heightTracksTextView = false
        
        return textView
    }
    func updateNSView(_ nsView: NSTextView, context: Context) {
        if nsView.string != text {
            nsView.string = text
        }
    }
}
