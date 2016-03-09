//
//  TextField.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class TextField<TResultBlock: Block> : Tappable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func enterText(text: String) -> TResultBlock {
        return self.enterText(text, result: TResultBlock.self)
    }
    
    public func enterText<TCustomResultBlock : Block>(text: String, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.typeText(text)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func clearText() -> TResultBlock {
        return self.clearText(TResultBlock.self)
    }
    
    public func clearText<TCustomResultBlock : Block>(result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.clearText()
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
}