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
public class Slider<TResultBlock : Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public var normalizedSliderPosition: CGFloat {
        get {
            return self.backingElement.normalizedSliderPosition
        }
    }
    
    public func adjustToNormalizedSliderPosition(normalizedSliderPosition: CGFloat, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.adjustToNormalizedSliderPosition(normalizedSliderPosition, result: TResultBlock.self, constructingBlock: builder)
    }
    
    public func adjustToNormalizedSliderPosition<TCustomResultBlock : Block>(normalizedSliderPosition: CGFloat, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        self.backingElement.adjustToNormalizedSliderPosition(normalizedSliderPosition)
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }
}