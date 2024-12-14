//
//  BaseConvertHeaderView.swift
//  DevTools
//
//  Created by Karen on 2024/12/14.
//

import SwiftUI

public enum ConvertState: Int, CaseIterable {
    case AToB = 1
    case BToA = 2
}

struct BaseConvertHeaderView: View {
    private var convertA = ""
    private var convertB = ""
    private let onConvertClick: (_ state: ConvertState) -> Void
    
    @State private var convertState: ConvertState = .AToB
    
    init(convertA: String = "",
         convertB: String = "",
         onConvertClick: @escaping (_ state: ConvertState) -> Void) {
        self.convertA = convertA
        self.convertB = convertB
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
            
            Button(action: {
                onConvertClick(self.convertState)
            }, label: {
                Text("convert")
            })
        }
    }
}

#Preview {
    BaseConvertHeaderView(convertA: "A", convertB: "B") {state in
        if state == .AToB {
            print("AToB")
        } else {
            print("BToA")
        }
    }
}
