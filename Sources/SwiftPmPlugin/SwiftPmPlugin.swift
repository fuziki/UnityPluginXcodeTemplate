@_cdecl("swiftPmPlugin_toNumber")
public func swiftPmPlugin_toNumber(_ stringPtr: UnsafePointer<CChar>?) -> Int64 {
    let str = String(cString: stringPtr!)
    return Int64(SwiftPmPlugin.toNumber(string: str))
}

class SwiftPmPlugin {
    var text = "Hello, World!"
    static func toNumber(string: String) -> Int {
        return Int(string) ?? 0
    }
}
