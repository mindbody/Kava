//
//  Draggable.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class Draggable<TResultBlock: Block> : Tappable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func pressForDuration(duration: NSTimeInterval, thenDragToEntity entity: UITestEntity) -> TResultBlock {
        return self.pressForDuration(duration, thenDragToTestEntity: entity, result: TResultBlock.self)
    }

    public func pressForDuration<TCustomResultBlock: Block>(duration: NSTimeInterval, thenDragToTestEntity entity: UITestEntity, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.pressForDuration(duration, thenDragToElement: entity.backingElement)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func pressForDuration(duration: NSTimeInterval, thenDragToCoordinate coordinate: XCUICoordinate) -> TResultBlock {
        return self.pressForDuration(duration, thenDragToCoordinate: coordinate, result: TResultBlock.self)
    }
    
    public func pressForDuration<TCustomResultBlock: Block>(duration: NSTimeInterval, thenDragToCoordinate coordinate: XCUICoordinate, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.coordinateWithNormalizedOffset(CGVector(dx: 0, dy: 0)).pressForDuration(duration, thenDragToCoordinate: coordinate)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
}