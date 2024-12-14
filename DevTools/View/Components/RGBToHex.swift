//
//  RGBToHex.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

struct RGBToHex: View {
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            BaseConvertHeaderView(convertA: "RGB", convertB: "Hex") { state in
                onConvertClick(state: state)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(""),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func convertRGBToHex() {
        print("convertRGBToHex")
    }
    
    private func convertHextoRGB() {
        print("convertHextoRGB")
    }
    
    private func onConvertClick(state: ConvertState) {
        if state == .AToB {
            self.convertRGBToHex()
        } else {
            self.convertHextoRGB()
        }
    }
}

#Preview {
    RGBToHex()
}
