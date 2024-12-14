//
//  ContentView.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTool: ToolModel? = tools.first
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTool) {
                ForEach(tools) { tool in
                    Text(tool.name)
                        .tag(tool)
                        .font(.system(size: 14))
                }
            }
            .frame(minWidth: 100)
            .navigationTitle("left split")
        } detail: {
            if let tool = selectedTool {
                tool.detailView
            } else {
                Text("👈Choose a tool")
            }
        }
        .navigationTitle("")
    }
}

#Preview {
    ContentView()
}
