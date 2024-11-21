//
//  ToolDataSource.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

let tools = [
    ToolModel(name: "JSON↔️String", detailView: AnyView(JSONToStringDetailView())),
    ToolModel(name: "URLEncode/Decode", detailView: AnyView(URLEncodeDetailView())),
    ToolModel(name: "Chinese↔️Unicode", detailView: AnyView(ChineseToUnicodeDetailView())),
    ToolModel(name: "Timestamp ", detailView: AnyView(TimestampDetailView())),
    ToolModel(name: "QR Code", detailView: AnyView(UnfinishedDetailView())),
    ToolModel(name: "Workflow", detailView: AnyView(UnfinishedDetailView())),
]
