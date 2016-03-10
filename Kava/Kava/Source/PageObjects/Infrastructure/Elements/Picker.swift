//
//  Picker.swift
//  Kava
//
//  Created by John Hammerlund on 3/8/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class PickerWheel<TResultBlock : Block> : Element {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func adjustToPickerWheelValue(value: String) -> TResultBlock {
        return self.adjustToPickerWheelValue(value, result: TResultBlock.self)
    }
    
    public func adjustToPickerWheelValue<TCustomResultBlock : Block>(value: String, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.adjustToPickerWheelValue(value)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
}

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