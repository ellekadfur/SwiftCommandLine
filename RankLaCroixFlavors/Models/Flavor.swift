//
//  Flavor.swift
//  RankLaCroixFlavors
//
//  Created by Lamar Jay Caaddfiir on 1/10/19.
//  Copyright © 2019 Lamar Jay Caaddfiir. All rights reserved.
//

import Foundation

struct Flavor {
  let rating: Int
  let title: String
  
  func print () -> String {
    return "\(title), \(rating) pts"
  }
}
