//
//  Swipeable.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class Swipeable<TResultBlock: Block> : Draggable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func swipeUp() -> TResultBlock {
        return self.swipeUp(TResultBlock.self)
    }
    
    public func swipeUp<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.swipeUp()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func swipeRight() -> TResultBlock {
        return self.swipeRight(TResultBlock.self)
    }
    
    public func swipeRight<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.swipeRight()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func swipeDown() -> TResultBlock {
        return self.swipeDown(TResultBlock.self)
    }
    
    public func swipeDown<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.swipeDown()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func swipeLeft() -> TResultBlock {
        return self.swipeLeft(TResultBlock.self)
    }
    
    public func swipeLeft<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.swipeLeft()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
}