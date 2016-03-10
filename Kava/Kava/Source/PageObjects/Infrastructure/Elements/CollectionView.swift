//
//  CollectionView.swift
//  Kava
//
//  Created by John Hammerlund on 3/9/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public enum ScrollDirection {
    case Horizontal
    case Vertical
}

public class CollectionView<TResultBlock : Block> : Element {
    
    private let scrollDirection: ScrollDirection
    
    public var visibleCells: [Swipeable<TResultBlock>] {
        get {
            return self.backingElement.cells.allElementsBoundByIndex.map {
                return Swipeable(parentBlock: self.parentBlock, backingElement: $0)
            }
        }
    }
    
    public init(scrollDirection: ScrollDirection, parentBlock: Block, backingElement: XCUIElement) {
        self.scrollDirection = scrollDirection
        super.init(parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public required convenience init(parentBlock: Block, backingElement: XCUIElement) {
        self.init(scrollDirection: .Vertical, parentBlock: parentBlock, backingElement: backingElement)
    }
    
    public func scrollToCellAtIndex(index: UInt) -> Self {
        
    }
    
}