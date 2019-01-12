//
//  main.swift
//  RankLaCroixFlavors
//
//  Created by Lamar Jay Caaddfiir on 12/25/18.
//  Copyright © 2018 Lamar Jay Caaddfiir. All rights reserved.
//

import Foundation

let app = App()
if CommandLine.argc < 2 {
  app.interactiveMode()
} else {
  app.doesNotHandleNonInteractiveMode()
}

