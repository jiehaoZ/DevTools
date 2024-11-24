//
//  DetailView.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

struct UnfinishedDetailView: View {
    var body: some View {
        Text("To Be Continued...")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    UnfinishedDetailView()
}
