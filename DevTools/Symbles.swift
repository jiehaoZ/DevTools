//
//  ContentView.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

struct Symbols: View {
    var body: some View {
        VStack {
            Image(systemName: "globe.europe.africa.fill")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .symbolEffect(.pulse)
            
            Image(systemName: "airplane")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .symbolEffect(.pulse)
        }
        .padding()
    }
}

#Preview {
    Symbols()
}
