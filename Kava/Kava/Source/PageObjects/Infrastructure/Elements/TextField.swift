//
//  TextField.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 An element with editable text. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
public class TextField<TResultBlock: Block> : Tappable<TResultBlock> {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func enterText(text: String, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.enterText(text, result: TResultBlock.self, constructingBlock: builder)
    }
    
    public func enterText<TCustomResultBlock : Block>(text: String, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.typeText(text)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
    public func clearText(constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.clearText(TResultBlock.self, constructingBlock: builder)
    }
    
    public func clearText<TCustomResultBlock : Block>(result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.clearText()
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
}