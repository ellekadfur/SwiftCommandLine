//
//  ConsoleIO.swift
//  RankLaCroixFlavors
//
//  Created by Lamar Jay Caaddfiir on 12/25/18.
//  Copyright © 2018 Lamar Jay Caaddfiir. All rights reserved.
//

import Foundation

enum OutputType {
  case error
  case standard
}

class ConsoleIO {
  
  //MARK: - Write
  func writeMessage(_ message: String, to: OutputType = .standard) {
    switch to {
    case .standard:
      print("\u{001B}[;m\(message)")
    //      print("\(message)")
    case .error:
      //      fputs("\(message)\n", stderr)
      fputs("\u{001B}[0;31m\(message)\n", stderr)
    }
  }
  
  //MARK: - Help
  func printHelp() {
    let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
    writeMessage("usage:")
    writeMessage("\(executableName) -f filename")
    writeMessage("or")
    writeMessage("\(executableName) -s sample-input.txt")
    writeMessage("or")
    writeMessage("\(executableName) -h to show usage information")
    writeMessage("Type \(executableName) without an option to enter interactive mode.")
  }
  
  //MARK: - Get
  func getInput() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    let strData = String(data: inputData, encoding: String.Encoding.utf8)!
    return strData.trimmingCharacters(in: CharacterSet.newlines)
  }
  
  func getAllInput() -> String {
    var inputArray: [String] = []
    for _ in 0..<15 {
      inputArray.append(readLine()!)
    }
    return inputArray.joined(separator: "\n")
  }
  
}
