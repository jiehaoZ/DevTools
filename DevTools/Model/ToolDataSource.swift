//
//  ToolDataSource.swift
//  DevTools
//
//  Created by Karen on 2024/9/22.
//

import SwiftUI

let tools = [
    ToolModel(name: "String↔️JSON", detailView: AnyView(JSONToStringDetailView())),
    ToolModel(name: "EncodedURL↔️URL", detailView: AnyView(URLEncodeDetailView())),
    ToolModel(name: "EscapedString↔️String", detailView: AnyView(StringEscapeDetailView())),
    ToolModel(name: "Unicode↔️Chinese", detailView: AnyView(ChineseToUnicodeDetailView())),
    ToolModel(name: "RGB↔️Hex", detailView: AnyView(RGBToHexDetailView())),
    ToolModel(name: "Timestamp ", detailView: AnyView(TimestampDetailView())),
    ToolModel(name: "QR Code", detailView: AnyView(QRCodeDetailView())),
    ToolModel(name: "Workflow", detailView: AnyView(UnfinishedDetailView())),
]
