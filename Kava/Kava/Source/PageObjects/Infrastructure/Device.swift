//
//  Device.swift
//  Kava
//
//  Created by John Hammerlund on 3/11/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A wrapper for XCUIDevice
*/
public final class Device {
    
    public static let sharedDevice = Device()
    
    fileprivate let device = XCUIDevice.shared()
    
    public var orientation: UIDeviceOrientation {
        get {
            return self.device.orientation
        }
        set {
            self.device.orientation = newValue
        }
    }
    
    fileprivate init() {}
    
    public func setOrientation(_ orientation: UIDeviceOrientation) -> Self {
        self.orientation = orientation
        return self
    }
    
    public func pressButton(_ button: XCUIDeviceButton) -> Self {
        self.device.press(button)
        return self
    }
    
}
