//
//  RGBToHexConvertView.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

struct RGBToHexConvertView: View {
    @State private var redValue: String = "0"
    @State private var greenValue: String = "0"
    @State private var blueValue: String = "0"
    @State private var alphaValue: String = "1"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    RGBSlider(colorType: .Red, value: $redValue)
                    RGBSlider(colorType: .Green, value: $greenValue)
                    RGBSlider(colorType: .Blue, value: $blueValue)
                    RGBSlider(colorType: .Alpha, value: $alphaValue)
                }
                Spacer()
                Rectangle()
                    .fill(resultColor)
                    .frame(width: 200, height: 100)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            Spacer().frame(height: 70)
            
            RGBToHexResultView(title: "Hex color code:", result: resultColor.toHexString() ?? "")
            RGBToHexResultView(title: "RGB color code:", result: "rgb(\(redValue),\(greenValue),\(blueValue))")
            RGBToHexResultView(title: "RGBA color code:", result: "rgba(\(redValue),\(greenValue),\(blueValue),\(alphaValue))")
        }
    }
    
    // MARK: Getter
    var resultColor: Color {
        return Color(red: (Double(redValue) ?? 0) / 255.0,
                     green: (Double(greenValue) ?? 0) / 255.0,
                     blue: (Double(blueValue) ?? 0) / 255.0,
                     opacity: Double(alphaValue) ?? 1)
    }
}

#Preview {
    RGBToHexConvertView()
}
