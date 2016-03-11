//
//  Pannable.swift
//  Kava
//
//  Created by John Hammerlund on 3/11/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class Pannable<TResultBlock: Block> : Swipeable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func pinchWithScale(scale: CGFloat, velocity: CGFloat) -> TResultBlock {
        return self.pinchWithScale(scale, velocity: velocity, result: TResultBlock.self)
    }
    
    public func pinchWithScale<TCustomResultBlock : Block>(scale: CGFloat, velocity: CGFloat, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.pinchWithScale(scale, velocity: velocity)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func rotate(rotation: CGFloat, withVelocity velocity: CGFloat) -> TResultBlock {
        return self.rotate(rotation, withVelocity: velocity, result: TResultBlock.self)
    }
    
    public func rotate<TCustomResultBlock : Block>(rotation: CGFloat, withVelocity velocity: CGFloat, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.rotate(rotation, withVelocity: velocity)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
}