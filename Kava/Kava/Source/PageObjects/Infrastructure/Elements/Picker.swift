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
public class PickerWheel<TResultBlock : Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func adjustToPickerWheelValue(value: String, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.adjustToPickerWheelValue(value, result: TResultBlock.self, constructingBlock: builder)
    }
    
    public func adjustToPickerWheelValue<TCustomResultBlock : Block>(value: String, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.adjustToPickerWheelValue(value)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
    
}

/**
 A standard picker or date picker. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
public class Picker<TResultBlock : Block> : Element {
    
    public lazy var pickerWheels: [PickerWheel<TResultBlock>] = {
        self.backingElement.pickers.allElementsBoundByIndex.map {
            return PickerWheel<TResultBlock>(parentBlock: self.parentBlock, backingElement: $0)
        }
    }()
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
}