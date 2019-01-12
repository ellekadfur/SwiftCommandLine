//
//  OptionType.swift
//  RankLaCroixFlavors
//
//  Created by Lamar Jay Caaddfiir on 1/10/19.
//  Copyright © 2019 Lamar Jay Caaddfiir. All rights reserved.
//

import Foundation

enum OptionType: String {
  case filename = "f"
  case sampleText = "s"
  case unknown
  case help = "h"
  case quit = "q"
  
  init(value: String) {
    switch value {
    case "q": self = .quit
    case "f": self = .filename
    case "h": self = .help
    case "s": self = .sampleText
    default: self = .unknown
    }
  }
}
