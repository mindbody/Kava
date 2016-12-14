//
//  Picker.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A picker wheel within a Picker. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
open class PickerWheel<TResultBlock : Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }

    @discardableResult
    open func adjust(toValue value: String, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.adjust(toValue: value, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func adjust<TCustomResultBlock : Block>(toValue value: String, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.adjust(toPickerWheelValue: value)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
}

/**
 A standard picker or date picker. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
open class Picker<TResultBlock : Block> : Element {
    
    open lazy var wheels: [PickerWheel<TResultBlock>] = {
        self.backingElement.pickers.allElementsBoundByIndex.map {
            return PickerWheel<TResultBlock>(parentBlock: self.parentBlock, backingElement: $0)
        }
    }()
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
}
