//
//  ToolModel.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

struct ToolModel: Identifiable, Hashable {
    static func == (lhs: ToolModel, rhs: ToolModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    let name: String
    let detailView: AnyView
}
