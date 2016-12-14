//
//  Draggable.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A draggable element. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
open class Draggable<TResultBlock: Block> : Tappable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }

    @discardableResult
    open func press(forDuration duration: TimeInterval, thenDragTo entity: UITestEntity, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.press(forDuration: duration, thenDragTo: entity, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func press<TCustomResultBlock: Block>(forDuration duration: TimeInterval, thenDragTo entity: UITestEntity, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.press(forDuration: duration, thenDragTo: entity.backingElement)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }

    @discardableResult
    open func press(forDuration duration: TimeInterval, thenDragTo coordinate: XCUICoordinate, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.press(forDuration: duration, thenDragTo: coordinate, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func press<TCustomResultBlock: Block>(forDuration duration: TimeInterval, thenDragTo coordinate: XCUICoordinate, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).press(forDuration: duration, thenDragTo: coordinate)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
