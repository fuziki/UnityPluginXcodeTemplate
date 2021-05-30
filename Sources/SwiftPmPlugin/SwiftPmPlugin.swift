import Metal
#if !os(macOS)
import UIKit
#endif

@_cdecl("swiftPmPlugin_toNumber")
public func swiftPmPlugin_toNumber(_ stringPtr: UnsafePointer<CChar>?) -> Int64 {
    let str = String(cString: stringPtr!)
    return Int64(SwiftPmPlugin.toNumber(string: str))
}

#if !os(macOS)
@_cdecl("swiftPmPlugin_saveImage")
public func swiftPmPlugin_saveImage(_ texturePtr: UnsafeRawPointer?) {
    guard let texturePtr = texturePtr else { return }
    let mtlTexture: MTLTexture = __bridge(texturePtr)
    SwiftPmPlugin.saveImage(mtlTexture: mtlTexture)
}
#endif

// UnsafeRawPointer == UnsafePointer<Void> == (void*)
func __bridge<T : AnyObject>(_ ptr: UnsafeRawPointer) -> T {
    return Unmanaged.fromOpaque(ptr).takeUnretainedValue()
}

@_cdecl("swiftPmPlugin_callBack")
public func swiftPmPlugin_callBack(_ handler: @convention(c) (UnsafePointer<CChar>) -> Void) {
    let str = "this is swift string"
    let nsStr = str as NSString
    handler(nsStr.utf8String!)
}

class SwiftPmPlugin {
    var text = "Hello, World!"
    static func toNumber(string: String) -> Int {
        return Int(string) ?? 0
    }
#if !os(macOS)
    static func saveImage(mtlTexture: MTLTexture) {
        let mtlTexture2 = mtlTexture.makeTextureView(pixelFormat: .rgba8Unorm_srgb)!
        let ci = CIImage(mtlTexture: mtlTexture2, options: nil)!
        let context = CIContext()
        let cg = context.createCGImage(ci, from: ci.extent)!
        let ui = UIImage(cgImage: cg)
        
        UIImageWriteToSavedPhotosAlbum(ui, nil, nil, nil)
    }
#endif
}
