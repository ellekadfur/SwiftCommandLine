//
//  App.swift
//  RankLaCroixFlavors
//
//  Created by Lamar Jay Caaddfiir on 12/25/18.
//  Copyright © 2018 Lamar Jay Caaddfiir. All rights reserved.
//

import Foundation


class App {
  
  //MARK: - Properties
  let consoleIO = ConsoleIO()
  private struct Constants {
    static let attendeeAcount: Int = 4
  }
  
  //MARK: - Private
  private func readData(_ string:String) -> String {
    let arrayContents = string.components(separatedBy: "\n")
    var person: [(String, Int)] = []
    var dictonary: [String: Int] = [:]
    var counter = 0
    for str in arrayContents {
      if str.count > 0 {
        let beforeIndex = str.index(before: str.endIndex)
        let flavor = str[..<beforeIndex]
        let rating = str.suffix(1)
        if let intRating = Int(String(rating)) {
          person.append((String(flavor), intRating))
          counter += 1
        }
        if counter > Constants.attendeeAcount {
          self.removeLowestAndSort(Array(person)).forEach { (k,v) in
            if let value = dictonary[k] {
              dictonary[k] = value + v
            } else {
              dictonary[k] = v
            }
          }
          person = []
          counter = 0
        }
      }
    }
    return self.finalArraySort(withDictionary: dictonary)
  }
  
  private func finalArraySort(withDictionary dictionary: [String: Int]) -> String {
    var array: [Flavor] = []
    var arrayString: [String] = []
    for (_, element) in dictionary.enumerated() {
      array.append(Flavor.init(rating: element.value, title: element.key.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    let sortedArray = array.sorted { (first, second) -> Bool in
      if first.rating > second.rating {
        return true
      } else if first.rating == second.rating {
        if first.title.count < second.title.count {
          return true
        } else {
          return false
        }
      } else {
        return false
      }
    }
    for i in 0..<sortedArray.count {
      let flavor = sortedArray[i]
      arrayString.append("\(i + 1). \(flavor.title), \(flavor.rating) pts")
    }
    return arrayString.joined(separator:"\n")
  }
  
  private func removeLowestAndSort(_ tuples:[(str:String, intValue:Int)]) -> [String: Int] {
    var dictionary: [String: Int] = [:]
    for tup in tuples {
      if tup.intValue == 5 {
        dictionary[tup.str] = 0
      } else if tup.intValue == 4 {
        dictionary[tup.str] = 1
      } else if tup.intValue == 3 {
        dictionary[tup.str] = 2
      } else if tup.intValue == 2 {
        dictionary[tup.str] = 3
      } else if tup.intValue == 1 {
        dictionary[tup.str] = 5
      }
    }
    return dictionary
  }
  
  private func getOption(_ option: String) -> (option:OptionType, value: String) {
    return (OptionType(value: option), option)
  }
  
  private func readSampleText(_ contents: String) -> (string: String, type: OutputType) {
    return (self.readData(contents), .standard)
  }
  
  private func read(filePath: String) -> (string: String, type: OutputType) {
    let currentPath = URL(fileURLWithPath:FileManager.default.currentDirectoryPath + filePath)
    print("Current path: \(currentPath.absoluteString)")
    do {
      let contents = try String(contentsOf: currentPath, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
      return (self.readData(contents), .standard)
    } catch let error as NSError {
      return ("Ooops! Something went wrong reading \(currentPath): \(error)", .error)
    }
  }
  
  //MARK: - Public
  func interactiveMode() {
    consoleIO.writeMessage("Welcome to LaCroix Flavor Ranking. This program reads a file that contains attendees flavor rankings and displays the overall ranking.")
    var shouldQuit = false
    while !shouldQuit {
      consoleIO.writeMessage("Type 'f' to enter a filename, 's' to use sample-input.txt, or type 'q' to quit.")
      let (option, value) = getOption(consoleIO.getInput())
      switch option {
      case .filename:
        consoleIO.writeMessage("Enter the file path (e.g /Downloads/Directory/filename.txt):")
        let filename = consoleIO.getInput()
        let tup = self.read(filePath: filename)
        consoleIO.writeMessage("\(tup.string)", to:tup.type)
      case .sampleText:
        consoleIO.writeMessage("Enter the sample-input.txt contents & press enter:")
        let input = consoleIO.getAllInput()
        let tup = self.readSampleText(input)
        consoleIO.writeMessage("\(tup.string)", to:tup.type)
      case .quit:
        shouldQuit = true
      default:
        consoleIO.writeMessage("Unknown option \(value)", to: .error)
      }
    }
  }
  
  func doesNotHandleNonInteractiveMode() {
    consoleIO.writeMessage("App does not handle Non-interactive mode option", to: .error)
  }
  
}
