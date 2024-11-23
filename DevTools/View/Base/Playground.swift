//
//  Playground.swift
//  DevTools
//
//  Created by Karen on 2024/11/23.
//

import AppKit
import SwiftUI
import CoreImage.CIFilterBuiltins

struct Playground: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            // 使用 generateQRCode() 函数生成二维码
            if let nsImage = generateQRCode(from: "https://baidu.com") {
                Image(nsImage: nsImage)
                    .interpolation(.none) // 防止图像模糊
                    .resizable()
                    .frame(width: 300, height: 300)
            } else {
                Text("无法生成二维码")
            }
        }
        .padding()
    }
    
    // 将字符串转换为二维码图像
    func generateQRCode(from string: String) -> NSImage? {
        filter.message = Data(string.utf8)
        
        // 设置纠错级别
        filter.correctionLevel = "Q"
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // 调整缩放比例
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledImage = outputImage.transformed(by: transform)
        
        // 将 CIImage 转换为 NSImage
        if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
            let nsImage = NSImage(cgImage: cgImage, size: NSSize(width: cgImage.width, height: cgImage.height))
            return nsImage
        }
        
        return nil
    }
}

#Preview {
    Playground()
}
