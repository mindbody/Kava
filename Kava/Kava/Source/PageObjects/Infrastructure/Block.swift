//
//  Block.swift
//  Kava
//
//  Created by John Hammerlund on 2/18/16.
//  Copyright © 2016 MINDBODY Inc. All rights reserved.
//

import Foundation
import XCTest

public protocol Block : UITestEntity {
    
    var parentBlock: Block? { get set }
    
    init(parentBlock: Block?, session: TestSession)
    
    func exists() -> Bool
    
}

public extension Block {
    
    public func rootBlock() -> Block {
        if var parentBlock = self.parentBlock {
            while(parentBlock.parentBlock != nil) {
                parentBlock = parentBlock.parentBlock!
            }
            return parentBlock
        }
        return ApplicationBlock(parentBlock: nil, session: self.session)
    }
    
    public func scopeTo<TResultBlock : Block>(blockType: TResultBlock.Type, builder: (() -> TResultBlock)? = nil ) -> TResultBlock {
        if let blockBuilder = builder {
            return blockBuilder()
        }
        return TResultBlock(parentBlock: nil, session: self.session)
    }
}

public final class ApplicationBlock : Block {
    
    public private(set) var session: TestSession
    public var parentBlock: Block?
    
    public init(parentBlock: Block?, session: TestSession) {
        self.session = session
        self.parentBlock = parentBlock
    }
    
    public func exists() -> Bool {
        return true
    }
    
    public func rootBlock() -> Block {
        return self
    }
    
}

public class PageBlock : Block {
    
    public private(set) var session: TestSession
    public var parentBlock: Block?
    
    public required init(parentBlock: Block?, session: TestSession) {
        self.session = session
        self.parentBlock = parentBlock
    }
    
    public required convenience init(block: Block) {
        self.init(parentBlock: block.parentBlock, session: block.session)
    }
    
    public func exists() -> Bool {
        fatalError("Must override")
    }
    
    public func dismissKeyboard() -> Self {
        return self
    }
    
}
