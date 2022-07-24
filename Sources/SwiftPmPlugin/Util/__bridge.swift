//
//  __bridge.swift
//  
//
//  Created by fuziki on 2022/07/24.
//

// UnsafeRawPointer == UnsafePointer<Void> == (void*)
func __bridge<T : AnyObject>(_ ptr: UnsafeRawPointer) -> T {
    return Unmanaged.fromOpaque(ptr).takeUnretainedValue()
}
