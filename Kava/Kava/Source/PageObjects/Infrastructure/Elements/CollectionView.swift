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
    case horizontal
    case vertical
}

/**
 A collection view, which could be a table view. The provided generic argument 
 allows us to infer the proceeding block, defaulted to scope of the application
 */
open class CollectionView<TResultBlock : Block> : Element {
    
    public typealias TResultBlockBuilder = (() -> TResultBlock)?
    
    fileprivate let scrollDirection: ScrollDirection
    
    open var visibleCells: [Swipeable<TResultBlock>] {
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
        self.init(scrollDirection: .vertical, parentBlock: parentBlock, backingElement: backingElement)
    }
    
    //MARK: Scrolling
    
    fileprivate func scrollWithFunc<TCustomResultBlock : Block>(_ scrollFunction: (() -> Void), predicate: NSPredicate, timeout: TimeInterval, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        let endTimestamp = Date.timeIntervalSinceReferenceDate + timeout
        while(!predicate.evaluate(with: nil) && Date.timeIntervalSinceReferenceDate < endTimestamp) {
            scrollFunction()
        }
        return self.parentBlock.scopeTo(TCustomResultBlock.self, builder: builder)
    }

    @discardableResult
    open func scrollForwardUntil(predicate: NSPredicate, timeout: TimeInterval = 5, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.scrollForwardUntil(predicate: predicate, timeout: timeout, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func scrollForwardUntil<TCustomResultBlock : Block>(predicate: NSPredicate, timeout: TimeInterval = 5, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        let scrollForwardFunction = self.scrollDirection == .vertical ? self.backingElement.swipeUp : self.backingElement.swipeRight
        return self.scrollWithFunc(scrollForwardFunction, predicate: predicate, timeout: timeout, result: result, constructingBlock: builder)
    }

    @discardableResult
    open func scrollForwardUntil(_ predicateBlock: @escaping (() -> Bool), timeout: TimeInterval = 5, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.scrollForwardUntil(predicateBlock, timeout: timeout, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func scrollForwardUntil<TCustomResultBlock : Block>(_ predicateBlock: @escaping (() -> Bool), timeout: TimeInterval = 5, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        let predicate = NSPredicate { _ in
            return predicateBlock()
        }
        return self.scrollForwardUntil(predicate: predicate, timeout: timeout, result: result, constructingBlock: builder)
    }

    @discardableResult
    open func scrollBackwardsUntil(predicate: NSPredicate, timeout: TimeInterval = 5, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.scrollBackwardsUntil(predicate: predicate, timeout: timeout, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func scrollBackwardsUntil<TCustomResultBlock : Block>(predicate: NSPredicate, timeout: TimeInterval = 5, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        let scrollForwardFunction = self.scrollDirection == .vertical ? self.backingElement.swipeDown : self.backingElement.swipeLeft
        return self.scrollWithFunc(scrollForwardFunction, predicate: predicate, timeout: timeout, result: result, constructingBlock: builder)
    }

    @discardableResult
    open func scrollBackwardsUntil(_ predicateBlock: @escaping (() -> Bool), timeout: TimeInterval = 5, constructingBlock builder: TResultBlockBuilder = nil) -> TResultBlock {
        return self.scrollBackwardsUntil(predicateBlock, timeout: timeout, result: TResultBlock.self, constructingBlock: builder)
    }

    @discardableResult
    open func scrollBackwardsUntil<TCustomResultBlock : Block>(_ predicateBlock: @escaping (() -> Bool), timeout: TimeInterval = 5, result: TCustomResultBlock.Type, constructingBlock builder: (() -> TCustomResultBlock)? = nil) -> TCustomResultBlock {
        let predicate = NSPredicate { _ in
            return predicateBlock()
        }
        return self.scrollBackwardsUntil(predicate: predicate, timeout: timeout, result: result, constructingBlock: builder)
    }
    
}
