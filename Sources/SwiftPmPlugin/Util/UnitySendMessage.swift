//
//  UnitySendMessage.swift
//  
//
//  Created by fuziki on 2022/07/24.
//

#if os(iOS)
import Foundation
#endif

class UnityFramework {
    static func sendMessage(object: String, method: String, arg: String) {
#if os(iOS)
        let bundlePath = Bundle.main.bundlePath.appending("/Frameworks/UnityFramework.framework")
        guard let bundle = Bundle(path: bundlePath) else { return }
        let principalClass = bundle.principalClass as! NSObject.Type
        let unityFramework: NSObject = principalClass.value(forKey: "getInstance") as! NSObject
        let sendMessageToGOWithNameSelector: Selector = NSSelectorFromString("sendMessageToGOWithName:functionName:message:")
        callInstanceMethod(targetInstance: unityFramework,
                           selector: sendMessageToGOWithNameSelector,
                           argCStr1: (object as NSString).utf8String!,
                           argCStr2: (method as NSString).utf8String!,
                           argCStr3: (arg as NSString).utf8String!)
#endif
    }
#if os(iOS)
    private static func callInstanceMethod<T: NSObject>(targetInstance: T,
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
}
