//
//  Element.swift
//  Kava
//
//  Created by John Hammerlund on 3/7/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public protocol UITestEntity {
    
    var session: TestSession { get }
    
}

public class Element : UITestEntity {
    
    public private(set) var backingElement: XCUIElement?
    public private(set) var session: TestSession
    public private(set) var parentBlock: Block
    
    public required init(parentBlock: Block, backingElement: XCUIElement?) {
        self.session = parentBlock.session
        self.parentBlock = parentBlock
        self.backingElement = backingElement
    }
    
}

public class Tappable<TResultBlock: Block> : Element {
    
    public required init(parentBlock: Block, backingElement: XCUIElement?) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func tap() -> TResultBlock {
        return self.tap(TResultBlock.self)
    }
    
    public func tap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement?.tap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func doubleTap() -> TResultBlock {
        return self.doubleTap(TResultBlock.self)
    }
    
    public func doubleTap<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement?.doubleTap()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func tapWithNumberOfTaps(numberOfTaps: UInt, numberOfTouches: UInt) -> TResultBlock {
        return self.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches, result: TResultBlock.self)
    }
    
    public func tapWithNumberOfTaps<TCustomResultBlock : Block>(numberOfTaps: UInt, numberOfTouches: UInt, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement?.tapWithNumberOfTaps(numberOfTaps, numberOfTouches: numberOfTouches)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func pressForDuration(duration: NSTimeInterval) -> TResultBlock {
        return self.pressForDuration(duration, result: TResultBlock.self)
    }
    
    public func pressForDuration<TCustomResultBlock : Block>(duration: NSTimeInterval, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement?.pressForDuration(duration);
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
}

public class TextField<TResultBlock: Block> : Tappable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement?) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func enterText(text: String) -> TResultBlock {
        return self.enterText(text, result: TResultBlock.self)
    }
    
    public func enterText<TCustomResultBlock : Block>(text: String, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement?.typeText(text)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func clearText() -> TResultBlock {
        return self.clearText(TResultBlock.self)
    }
    
    public func clearText<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement?.clearText()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
}