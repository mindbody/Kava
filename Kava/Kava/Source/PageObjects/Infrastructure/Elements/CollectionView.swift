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
    
    //MARK: Scrolling
    
    private func scrollWithFunc<TCustomResultBlock : Block>(scrollFunction: (() -> Void), predicate: NSPredicate, timeout: NSTimeInterval, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        let endTimestamp = NSDate.timeIntervalSinceReferenceDate() + timeout
        while(predicate.evaluateWithObject(nil) && NSDate.timeIntervalSinceReferenceDate() < endTimestamp) {
            scrollFunction()
        }
        return self.parentBlock.scopeTo(TCustomResultBlock.self)
    }
    
    public func scrollForwardUntil(predicate: NSPredicate, timeout: NSTimeInterval = 5) -> TResultBlock {
        return self.scrollForwardUntil(predicate, timeout: timeout, result: TResultBlock.self)
    }
    
    public func scrollForwardUntil<TCustomResultBlock : Block>(predicate: NSPredicate, timeout: NSTimeInterval = 5, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        let scrollForwardFunction = self.scrollDirection == .Vertical ? self.backingElement.swipeDown : self.backingElement.swipeRight
        return self.scrollWithFunc(scrollForwardFunction, predicate: predicate, timeout: timeout, result: result)
    }
    
    public func scrollForwardUntil(block: (() -> Bool), timeout: NSTimeInterval = 5) -> TResultBlock {
        return self.scrollForwardUntil(block, timeout: timeout)
    }
    
    public func scrollForwardUntil<TCustomResultBlock : Block>(block: (() -> Bool), timeout: NSTimeInterval = 5, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        let predicate = NSPredicate { (_: AnyObject, _: [String : AnyObject]?) -> Bool in
            return block()
        }
        return self.scrollForwardUntil(predicate, timeout: timeout, result: result)
    }
    
    public func scrollBackwardsUntil(predicate: NSPredicate, timeout: NSTimeInterval = 5) -> TResultBlock {
        return self.scrollBackwardsUntil(predicate, timeout: timeout, result: TResultBlock.self)
    }
    
    public func scrollBackwardsUntil<TCustomResultBlock : Block>(predicate: NSPredicate, timeout: NSTimeInterval = 5, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        let scrollForwardFunction = self.scrollDirection == .Vertical ? self.backingElement.swipeUp : self.backingElement.swipeLeft
        return self.scrollWithFunc(scrollForwardFunction, predicate: predicate, timeout: timeout, result: result)
    }
    
    public func scrollBackwardsUntil(block: (() -> Bool), timeout: NSTimeInterval = 5) -> TResultBlock {
        return self.scrollBackwardsUntil(block, timeout: timeout, result: TResultBlock.self)
    }
    
    public func scrollBackwardsUntil<TCustomResultBlock : Block>(block: (() -> Bool), timeout: NSTimeInterval = 5, result: TCustomResultBlock.Type) -> TCustomResultBlock {
        let predicate = NSPredicate { (_: AnyObject, _: [String : AnyObject]?) -> Bool in
            return block()
        }
        return self.scrollBackwardsUntil(predicate, timeout: timeout, result: result)
    }
    
}