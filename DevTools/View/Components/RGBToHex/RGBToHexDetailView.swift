//
//  RGBToHex.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

struct RGBToHexDetailView: View {
    @State private var convertState: ConvertState = .AToB
        
    var body: some View {
        VStack(alignment: .leading) {
            BaseConvertHeaderView(convertA: "RGB",
                                  convertB: "Hex",
                                  convertState: $convertState)
            Spacer().frame(height: 15)
            convertPannel
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
    
    // MARK: UI
    private var convertPannel: some View {
        if convertState == .AToB {
            AnyView(RGBToHexConvertView())
        } else {
            AnyView(HexToRGBConvertView())
        }
    }
}

#Preview {
    RGBToHexDetailView()
}
