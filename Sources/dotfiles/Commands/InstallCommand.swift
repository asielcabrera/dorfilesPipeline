//
//  InstallCommand.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import ArgumentParser
import Logging

struct InstallCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "install",
        abstract: "Install programs and associated dotfiles.")
    
    mutating func run() throws {
        BrewProcedure.main()
        UpdateSettingProcedure.main()
        SymlinkPrecedure.main()
    }
}
