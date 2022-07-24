//
//  TextureSaver.swift
//  
//
//  Created by fuziki on 2022/07/24.
//

import Metal
#if os(iOS)
import UIKit
#endif

class TextureSaver {
    static func saveImage(mtlTexture: MTLTexture) {
#if os(iOS)
        let mtlTexture2 = mtlTexture.makeTextureView(pixelFormat: .rgba8Unorm_srgb)!
        let ci = CIImage(mtlTexture: mtlTexture2, options: nil)!
        let context = CIContext()
        let cg = context.createCGImage(ci, from: ci.extent)!
        let ui = UIImage(cgImage: cg)
        UIImageWriteToSavedPhotosAlbum(ui, nil, nil, nil)
#endif
    }
}
