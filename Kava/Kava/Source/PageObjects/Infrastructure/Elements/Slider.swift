//
//  Slider.swift
//  Kava
//
//  Created by John Hammerlund on 3/11/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public class Slider<TResultBlock : Block> : Element {
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public var normalizedSliderPosition: CGFloat {
        get {
            return self.backingElement.normalizedSliderPosition
        }
    }
    
    public func adjustToNormalizedSliderPosition(normalizedSliderPosition: CGFloat) -> TResultBlock {
        return self.adjustToNormalizedSliderPosition(normalizedSliderPosition, result: TResultBlock.self)
    }
    
    public func adjustToNormalizedSliderPosition<TCustomResultBlock : Block>(normalizedSliderPosition: CGFloat, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        self.backingElement.adjustToNormalizedSliderPosition(normalizedSliderPosition)
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
}