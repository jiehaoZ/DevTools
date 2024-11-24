//
//  ToolDataSource.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

let tools = [
    ToolModel(name: "JSON↔️String", detailView: AnyView(JSONToStringDetailView())),
    ToolModel(name: "URL↔️EncodedURL", detailView: AnyView(URLEncodeDetailView())),
    ToolModel(name: "String↔️EscapedString", detailView: AnyView(StringEscapeDetailView())),
    ToolModel(name: "Chinese↔️Unicode", detailView: AnyView(ChineseToUnicodeDetailView())),
    ToolModel(name: "Timestamp ", detailView: AnyView(TimestampDetailView())),
    ToolModel(name: "QR Code", detailView: AnyView(QRCodeDetailView())),
    ToolModel(name: "Workflow", detailView: AnyView(UnfinishedDetailView())),
]
