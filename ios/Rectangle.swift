//
//  Rectangle.swift
//  documentDeneme
//
//  Created by Alper Salık on 7.02.2022.
//

import Foundation
import UIKit

struct Rectangle: Codable {
  let x: CGFloat
  let y: CGFloat
  let width: CGFloat
  let height: CGFloat
  
  var dictionary: [String: Any] {
    return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
  }
  
  var nsDictionary: NSDictionary {
    return self.dictionary as NSDictionary
  }
}
