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
    
    open func pinchWithScale(_ scale: CGFloat, velocity: CGFloat, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.pinchWithScale(scale, velocity: velocity, result: TResultBlock.self, constructingBlock: builder)
    }
    
    open func pinchWithScale<TCustomResultBlock : Block>(_ scale: CGFloat, velocity: CGFloat, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.pinch(withScale: scale, velocity: velocity)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    open func rotate(_ rotation: CGFloat, withVelocity velocity: CGFloat, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.rotate(rotation, withVelocity: velocity, result: TResultBlock.self, constructingBlock: builder)
    }
    
    open func rotate<TCustomResultBlock : Block>(_ rotation: CGFloat, withVelocity velocity: CGFloat, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.rotate(rotation, withVelocity: velocity)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
