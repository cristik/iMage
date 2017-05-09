//
//  main.swift
//  iMage
//
//  Created by Cristian Kocza on 10/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import UIKit

// dummy empty app delegate for when running the unit tests
class DummyAppDelegate: NSObject, UIApplicationDelegate { }
let foundUnitTests = NSClassFromString("XCTest") != nil

UIApplicationMain(CommandLine.argc,
                  UnsafeMutableRawPointer(CommandLine.unsafeArgv)
                    .bindMemory(
                        to: UnsafeMutablePointer<Int8>.self,
                        capacity: Int(CommandLine.argc)),
                  nil,
                  NSStringFromClass(foundUnitTests ? DummyAppDelegate.self : AppDelegate.self))
