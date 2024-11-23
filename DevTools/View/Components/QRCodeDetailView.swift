//
//  QRCodeDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/11/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeDetailView: View {
    @State private var inputText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $inputText)
                .cornerRadius(5)
                .font(.title3)
                .frame(height: 25)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .opacity(0.4)
                )
                .autocorrectionDisabled(true)
            Spacer().frame(height: 20)
            if let nsImage = generateQRCode(from: inputText) {
                Image(nsImage: nsImage)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 400, height: 400)
            } else {
                Text("error string")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    func generateQRCode(from string: String) -> NSImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)
        
        filter.correctionLevel = "Q"
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // adjust the scale
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledImage = outputImage.transformed(by: transform)
        
        // convert CIImage to NSImage
        if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
            let nsImage = NSImage(cgImage: cgImage, size: NSSize(width: cgImage.width, height: cgImage.height))
            return nsImage
        }
        
        return nil
    }
}

#Preview {
    QRCodeDetailView()
}
