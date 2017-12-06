//
//  Tappable.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A tappable element. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
open class Tappable<TResultBlock: Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }

    @discardableResult
    open func tap(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.tap(result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func tap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.tap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }

    @discardableResult
    open func doubleTap(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.doubleTap(result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func doubleTap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.doubleTap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }

    @discardableResult
    open func tap(withNumberOfTaps numberOfTaps: UInt, numberOfTouches: UInt, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: numberOfTouches, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func tap<TCustomResultBlock : Block>(withNumberOfTaps numberOfTaps: UInt, numberOfTouches: UInt, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.tap(withNumberOfTaps: Int(numberOfTaps), numberOfTouches: Int(numberOfTouches))
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }

    @discardableResult
    open func press(forDuration duration: TimeInterval, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.press(forDuration: duration, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func press<TCustomResultBlock : Block>(forDuration duration: TimeInterval, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.press(forDuration: duration);
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
