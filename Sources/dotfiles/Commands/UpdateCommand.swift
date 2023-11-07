//
//  UpdateCommand.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import ArgumentParser

struct UpdateCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "update",
        abstract: "Update programs and associated dotfiles.")
    
}
