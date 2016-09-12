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
open class Swipeable<TResultBlock: Block> : Draggable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    open func swipeUp(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeUp(TResultBlock.self, constructingBlock: builder)
    }
    
    open func swipeUp<TCustomResultBlock : Block>(_ result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeUp()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func swipeRight(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeRight(TResultBlock.self, constructingBlock: builder)
    }
    
    open func swipeRight<TCustomResultBlock : Block>(_ result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeRight()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func swipeDown(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeDown(TResultBlock.self, constructingBlock: builder)
    }
    
    open func swipeDown<TCustomResultBlock : Block>(_ result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeDown()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func swipeLeft(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.swipeLeft(TResultBlock.self, constructingBlock: builder)
    }
    
    open func swipeLeft<TCustomResultBlock : Block>(_ result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.swipeLeft()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
}
