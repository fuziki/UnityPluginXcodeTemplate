//
//  UnityInterface_iOS.swift
//  
//
//  Created by fuziki on 2022/07/24.
//

#if os(iOS)
import Metal
import UIKit

@_cdecl("swiftPmPlugin_saveImage")
public func swiftPmPlugin_saveImage(_ texturePtr: UnsafeRawPointer?) {
    guard let texturePtr = texturePtr else { return }
    let mtlTexture: MTLTexture = __bridge(texturePtr)
    TextureSaver.saveImage(mtlTexture: mtlTexture)
}

@_cdecl("swiftPmPlugin_callSendMessage")
public func swiftPmPlugin_callSendMessage() {
    UnityFramework.sendMessage(object: "Cube", method: "Sent", arg: "from send message")
}
#endif
