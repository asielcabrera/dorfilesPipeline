//
//  DotfilesPipelineCommand.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 2/20/23.
//
//

import ArgumentParser
import Logging


@main
struct DotfilesPipelineCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "dotfiles",
        abstract: "My command-line tool",
        subcommands: [InstallCommand.self, UpdateCommand.self, UninstallCommand.self])
     
    mutating func run() throws {
        LoggingSystem.bootstrap { label in
            var logger = StreamLogHandler.standardOutput(label: label)
            logger.logLevel = .info
            return logger
        }
    }
}
