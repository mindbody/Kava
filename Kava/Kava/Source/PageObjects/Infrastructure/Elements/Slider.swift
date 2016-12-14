//
//  Slider.swift
//  Kava
//
//  Created by John Hammerlund on 3/11/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 An iOS slider. The provided generic argument allows us to infer
 the proceeding block, defaulted to scope of the application
 */
open class Slider<TResultBlock : Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    open var normalizedSliderPosition: CGFloat {
        get {
            return self.backingElement.normalizedSliderPosition
        }
    }

    @discardableResult
    open func adjust(toNormalizedSliderPosition normalizedSliderPosition: CGFloat, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.adjust(toNormalizedSliderPosition: normalizedSliderPosition, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func adjust<TCustomResultBlock : Block>(toNormalizedSliderPosition normalizedSliderPosition: CGFloat, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.adjust(toNormalizedSliderPosition: normalizedSliderPosition)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}
