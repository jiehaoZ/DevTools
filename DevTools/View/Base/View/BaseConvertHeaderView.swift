//
//  BaseConvertHeaderView.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

public enum ConvertState: Int, CaseIterable {
    case AToB, BToA
}

struct BaseConvertHeaderView: View {
    private var convertA = ""
    private var convertB = ""
    @Binding private var convertState: ConvertState
    private let onConvertClick: ((_ state: ConvertState) -> Void)?
    
    init(convertA: String = "",
         convertB: String = "",
         convertState: Binding<ConvertState>,
         onConvertClick: ((_ state: ConvertState) -> Void)? = nil) {
        self.convertA = convertA
        self.convertB = convertB
        _convertState = convertState
        self.onConvertClick = onConvertClick
    }
    
    var body: some View {
        HStack {
            Picker("", selection: $convertState) {
                ForEach(ConvertState.allCases, id: \.self) { state in
                    if state == .AToB {
                        Text("\(convertA)➡️\(convertB)")
                    } else {
                        Text("\(convertB)➡️\(convertA)")
                    }
                    
                }
            }
            .pickerStyle(MenuPickerStyle())
            .fixedSize()
            
            Spacer()
            if let onConvertClick {
                Button(action: {
                    onConvertClick(self.convertState)
                }, label: {
                    Text("convert")
                        .font(.system(size: 14))
                })
            }
        }
    }
}

#Preview {
    BaseConvertHeaderView(convertA: "A", convertB: "B", convertState: Binding.constant(.AToB)) {state in
        if state == .AToB {
            print("AToB")
        } else {
            print("BToA")
        }
    }
}
