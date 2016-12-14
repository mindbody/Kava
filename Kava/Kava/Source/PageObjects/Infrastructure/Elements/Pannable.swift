//
//  Pannable.swift
//  Kava
//
//  Created by John Hammerlund on 3/11/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A pannable element. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
open class Pannable<TResultBlock: Block> : Swipeable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }

    @discardableResult
    open func pinch(scale: CGFloat, velocity: CGFloat, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.pinch(scale: scale, velocity: velocity, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func pinch<TCustomResultBlock : Block>(scale: CGFloat, velocity: CGFloat, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.pinch(withScale: scale, velocity: velocity)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }

    @discardableResult
    open func rotate(rotation: CGFloat, velocity: CGFloat, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.rotate(rotation: rotation, velocity: velocity, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func rotate<TCustomResultBlock : Block>(rotation: CGFloat, velocity: CGFloat, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.rotate(rotation, withVelocity: velocity)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
