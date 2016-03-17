//
//  Swipeable.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A swipeable element. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
public class Swipeable<TResultBlock: Block> : Draggable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func swipeUp(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeUp(TResultBlock.self, constructingBlock: builder)
    }
    
    public func swipeUp<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeUp()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func swipeRight(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeRight(TResultBlock.self, constructingBlock: builder)
    }
    
    public func swipeRight<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeRight()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func swipeDown(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeDown(TResultBlock.self, constructingBlock: builder)
    }
    
    public func swipeDown<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeDown()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func swipeLeft(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeLeft(TResultBlock.self, constructingBlock: builder)
    }
    
    public func swipeLeft<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeLeft()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
}