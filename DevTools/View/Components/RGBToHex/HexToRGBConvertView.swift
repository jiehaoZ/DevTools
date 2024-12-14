//
//  HexToRGBConvertView.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

struct HexToRGBConvertView: View {
    @State private var hexString: String = ""
    
    var body: some View {
        Text("Hex color code: \(resultColor.toHexString() ?? "")")
            .font(.title)
            .bold()
        NonEditableTextField(text: $hexString, isEditable: true)
            .frame(width: 270)
        
        Spacer().frame(height: 30)
        
        Rectangle()
            .fill(resultColor)
            .frame(width: 400, height: 150)
            .cornerRadius(10)
            .shadow(radius: 10)
        
        Spacer().frame(height: 30)
        
        RGBToHexResultView(title: "RGB color code:", result: rgbString)
        RGBToHexResultView(title: "RGBA color code:", result: rgbaString)
    }
    
    // MARK: Getter
    var resultColor: Color {
        return Color(hex: hexString) ?? .black
    }
    
    var rgbString: String {
        guard let rgbaComponents = resultColor.getRGBAComponents() else { return "" }
        return "rgb(\(rgbaComponents.r),\(rgbaComponents.g),\(rgbaComponents.b))"
    }
    
    var rgbaString: String {
        guard let rgbaComponents = resultColor.getRGBAComponents() else { return "" }
        return "rgba(\(rgbaComponents.r),\(rgbaComponents.g),\(rgbaComponents.b),\(rgbaComponents.a))"
    }
}

#Preview {
    HexToRGBConvertView()
}
