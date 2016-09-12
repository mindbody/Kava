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
    
    open func tap(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.tap(TResultBlock.self, constructingBlock: builder)
    }
    
    open func tap<TCustomResultBlock : Block>(_ result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.tap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func doubleTap(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.doubleTap(TResultBlock.self, constructingBlock: builder)
    }
    
    open func doubleTap<TCustomResultBlock : Block>(_ result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.doubleTap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func tapWithNumberOfTaps(_ numberOfTaps: UInt, numberOfTouches: UInt, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches, result: TResultBlock.self, constructingBlock: builder)
    }
    
    open func tapWithNumberOfTaps<TCustomResultBlock : Block>(_ numberOfTaps: UInt, numberOfTouches: UInt, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: numberOfTouches)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func pressForDuration(_ duration: TimeInterval, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.pressForDuration(duration, result: TResultBlock.self, constructingBlock: builder)
    }
    
    open func pressForDuration<TCustomResultBlock : Block>(_ duration: TimeInterval, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.press(forDuration: duration);
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
