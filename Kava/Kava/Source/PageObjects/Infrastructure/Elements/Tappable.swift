//
//  Tappable.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class Tappable<TResultBlock: Block> : Element {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func tap() -> TResultBlock {
        return self.tap(TResultBlock.self)
    }
    
    public func tap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.tap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func doubleTap() -> TResultBlock {
        return self.doubleTap(TResultBlock.self)
    }
    
    public func doubleTap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.doubleTap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func tapWithNumberOfTaps(numberOfTaps: UInt, numberOfTouches: UInt) -> TResultBlock {
        return self.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches, result: TResultBlock.self)
    }
    
    public func tapWithNumberOfTaps<TCustomResultBlock : Block>(numberOfTaps: UInt, numberOfTouches: UInt, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func pressForDuration(duration: NSTimeInterval) -> TResultBlock {
        return self.pressForDuration(duration, result: TResultBlock.self)
    }
    
    public func pressForDuration<TCustomResultBlock : Block>(duration: NSTimeInterval, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.pressForDuration(duration);
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
}
