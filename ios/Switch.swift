//
//  Switch.swift
//  documentDeneme
//
//  Created by Alper Salık on 7.02.2022.
//

import Foundation
import UIKit

@objc(Switch)
class Switch: RCTViewManager {
  
  override func view() -> UIView! {
    return SwitchView().view
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
