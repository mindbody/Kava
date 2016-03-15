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
public class Tappable<TResultBlock: Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func tap(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.tap(TResultBlock.self, constructingBlock: builder)
    }
    
    public func tap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.tap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func doubleTap(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.doubleTap(TResultBlock.self, constructingBlock: builder)
    }
    
    public func doubleTap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.doubleTap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func tapWithNumberOfTaps(numberOfTaps: UInt, numberOfTouches: UInt, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches, result: TResultBlock.self, constructingBlock: builder)
    }
    
    public func tapWithNumberOfTaps<TCustomResultBlock : Block>(numberOfTaps: UInt, numberOfTouches: UInt, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func pressForDuration(duration: NSTimeInterval, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.pressForDuration(duration, result: TResultBlock.self, constructingBlock: builder)
    }
    
    public func pressForDuration<TCustomResultBlock : Block>(duration: NSTimeInterval, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.pressForDuration(duration);
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
