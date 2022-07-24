//
//  UnityInterface.swift
//  
//
//  Created by fuziki on 2022/07/24.
//

import Foundation

@_cdecl("swiftPmPlugin_toNumber")
public func swiftPmPlugin_toNumber(_ stringPtr: UnsafePointer<CChar>?) -> Int64 {
    let str = String(cString: stringPtr!)
    return Int64(Int(str) ?? 0)
}

@_cdecl("swiftPmPlugin_callBack")
public func swiftPmPlugin_callBack(_ handler: @convention(c) (UnsafePointer<CChar>) -> Void) {
    let str = "this is swift string"
    let nsStr = str as NSString
    let resNsStrPtr: UnsafePointer<CChar> = nsStr.utf8String!
    let resNsStrPtrDup: UnsafeMutablePointer<CChar> = strdup(resNsStrPtr)
    handler(resNsStrPtrDup)
}
