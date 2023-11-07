//
//  UninstallCommand.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import ArgumentParser
import Logging

struct UninstallCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "uninstall",
        abstract: "Uninstall programs and associated dotfiles.")
    
    mutating func run() throws {
        
    }
}
