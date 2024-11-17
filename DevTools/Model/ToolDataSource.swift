//
//  ToolDataSource.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

let tools = [
    ToolModel(name: "JSON↔️String", detailView: AnyView(JSONToStringDetailView())),
    ToolModel(name: "JSON转义", detailView: AnyView(UnfinishedDetailView())),
    ToolModel(name: "中文↔️Unicode", detailView: AnyView(UnfinishedDetailView())),
    ToolModel(name: "Time Stamp ", detailView: AnyView(UnfinishedDetailView())),
    ToolModel(name: "QR Code", detailView: AnyView(UnfinishedDetailView())),
    ToolModel(name: "QR Code", detailView: AnyView(UnfinishedDetailView())),
    ToolModel(name: "Workflow", detailView: AnyView(UnfinishedDetailView())),
]
