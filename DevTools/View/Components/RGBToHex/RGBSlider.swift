//
//  RGBSlider.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

public enum RGBSliderColorType: Int {
    case Red, Green, Blue, Alpha
}

struct RGBSlider: View {
    private let colorType: RGBSliderColorType
    // 0...255
    @Binding private var value: String
    @State private var sliderValue: Double = 0.0
    
    init(colorType: RGBSliderColorType, value: Binding<String>) {
        self.colorType = colorType
        _value = value
        _sliderValue = State(initialValue: colorType != .Alpha ? 0 : 1)
    }
    
    var body: some View {
        HStack {
            Text(getTitle())
                .frame(width: 70, alignment: .leading)
                .font(.system(size: 16))
            TextField("0", text: $value)
                .frame(width: 80)
                .onChange(of: value) { _, _ in
                    if let intValue = Int(value) {
                        sliderValue = colorType != .Alpha ? Double(intValue) / 255.0 : Double(intValue)
                    }
                }
            Slider(value: $sliderValue, in: 0...1)
                .frame(width: 240)
                .onChange(of: sliderValue) { _, _ in
                    if colorType != .Alpha {
                        let intValue = Int(sliderValue * 255.0)
                        value = String(intValue)
                    } else {
                        value = String(format: "%.2f", sliderValue)
                    }
                }
                .tint(getColor())
        }
    }
    
    // Getter
    private func getTitle() -> String {
        if colorType == .Red {
            return "Red(R)"
        } else if colorType == .Green {
            return "Green(G)"
        } else if colorType == .Blue {
            return "Blue(B)"
        } else {
            return "Alpha(A)"
        }
    }
    private func getColor() -> Color {
        if colorType == .Red {
            return .red
        } else if colorType == .Green {
            return .green
        } else if colorType == .Blue {
            return .blue
        } else {
            return .primary
        }
    }
}

#Preview {
    RGBSlider(colorType: .Red, value: Binding.constant("0"))
}
