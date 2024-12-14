//
//  RGBToHexResultView.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

struct RGBToHexResultView: View {
    private let title: String
    private let result: String
    
    init(title: String, result: String) {
        self.title = title
        self.result = result
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
            NonEditableTextField(text: Binding.constant(result), isEditable: false)
                .frame(width: 270)
        }
        Spacer().frame(height: 15)
    }
}

#Preview {
    RGBToHexResultView(title: "Hex color code", result: "#777777")
}
