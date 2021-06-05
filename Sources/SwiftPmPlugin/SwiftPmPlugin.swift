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

// UnsafeRawPointer == UnsafePointer<Void> == (void*)
func __bridge<T : AnyObject>(_ ptr: UnsafeRawPointer) -> T {
    return Unmanaged.fromOpaque(ptr).takeUnretainedValue()
}
#endif

@_cdecl("swiftPmPlugin_callBack")
public func swiftPmPlugin_callBack(_ handler: @convention(c) (UnsafePointer<CChar>) -> Void) {
    let str = "this is swift string"
    let nsStr = str as NSString
    handler(nsStr.utf8String!)
}

#if !os(macOS)
@_cdecl("swiftPmPlugin_callSendMessage")
public func swiftPmPlugin_callSendMessage() {
    let bundlePath = Bundle.main.bundlePath.appending("/Frameworks/UnityFramework.framework")
    guard let bundle = Bundle(path: bundlePath) else { return }
    let principalClass = bundle.principalClass as! NSObject.Type
    let unityFramework: NSObject = principalClass.value(forKey: "getInstance") as! NSObject
    
    let sendMessageToGOWithNameSelector: Selector = NSSelectorFromString("sendMessageToGOWithName:functionName:message:")
    
    callInstanceMethod(targetInstance: unityFramework,
                       selector: sendMessageToGOWithNameSelector,
                       argCStr1: ("Cube" as NSString).utf8String!,
                       argCStr2: ("Sent" as NSString).utf8String!,
                       argCStr3: ("from send message" as NSString).utf8String!)
}

private func callInstanceMethod<T: NSObject>(targetInstance: T,
                                             selector: Selector,
                                             argCStr1: UnsafePointer<CChar>,
                                             argCStr2: UnsafePointer<CChar>,
                                             argCStr3: UnsafePointer<CChar>) {
    typealias methodType = @convention(c) (
        Any, Selector,
        // args
        UnsafePointer<CChar>, UnsafePointer<CChar>, UnsafePointer<CChar>
    ) -> Void
    let methodImplementation: IMP = class_getMethodImplementation(type(of: targetInstance), selector)!
    let methodInvocation = unsafeBitCast(methodImplementation,
                                         to: methodType.self)
    methodInvocation(targetInstance, selector, argCStr1, argCStr2, argCStr3)
}
#endif

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
