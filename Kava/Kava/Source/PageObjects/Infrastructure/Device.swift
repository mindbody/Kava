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
    
    private let device = XCUIDevice.sharedDevice()
    
    public var orientation: UIDeviceOrientation {
        get {
            return self.device.orientation
        }
        set {
            self.device.orientation = newValue
        }
    }
    
    private init() {}
    
    public func setOrientation(orientation: UIDeviceOrientation) -> Self {
        self.orientation = orientation
        return self
    }
    
    public func pressButton(button: XCUIDeviceButton) -> Self {
        self.device.pressButton(button)
        return self
    }
    
}