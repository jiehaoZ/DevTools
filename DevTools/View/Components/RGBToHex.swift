//
//  RGBToHex.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

struct RGBToHex: View {
    @State var convertState: ConvertState = .AToB
    // Alert
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            BaseConvertHeaderView(convertA: "RGB",
                                  convertB: "Hex",
                                  convertState: $convertState) { state in
                onConvertClick(state: state)
            }
            convertPannel
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(""),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
    
    // MARK: UI
    private var convertPannel: some View {
        if convertState == .AToB {
            Text("RGBToHex")
        } else {
            Text("HexToRGB")
        }
    }
    
    private var rgbToHexConvertPannel: some View {
        Text("rgbToHexConvertPannel")
    }
    
    private var hexToRGBConvertPannel: some View {
        Text("hexToRGBConvertPannel")
    }
    
    // MARK: Actions
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
