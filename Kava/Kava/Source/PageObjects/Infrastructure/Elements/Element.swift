//
//  Element.swift
//  Kava
//
//  Created by John Hammerlund on 3/7/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public protocol Element {
    
    var backingElement: XCUIElement 
    
//    public init(backingElement: XCUIElement) {
//        self.backingElement = backingElement
//    }
//    
//    public func performAction<T: Block>(returnBlock: T.Type) -> T {
//        return T(s)
//    }
    
}