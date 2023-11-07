//
//  main.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 2/20/23.
//
//
//import ArgumentParser
//import Logging

//let homeDir = FileManager.default.homeDirectoryForCurrentUser
//let dotfileRepoDir = URL(fileURLWithPath: "~/dotfiles")
//
//let source = dotfileRepoDir.appendingPathComponent("dotfile")
//let destination = homeDir.appendingPathComponent("dotfiles/cofig.yml")
//
//let test2 = String(argument: Terminal().shell.cat("~/dotfiles/config.yml").stdout)
//print(test2!)
//
//let configYaml = String(test2?.description ?? "")
//let config = try YAMLDecoder().decode(Config.self, from: configYaml )

//var package = DotfilePackage()
//
//for programConfig in config.programs {
//    let program = Program(name: programConfig.name, version: programConfig.version, dotfiles: programConfig.dotfiles)
//    package.programs.append(program)
//}
//
//for dotfile in package.dotfiles {
//    let filename = "\(dotfile.name).\(dotfile.extension)"
//    let path = "\(config.dotfilesDirectory)/\(filename)"
//    if let contents = try? String(contentsOfFile: path) {
//        dotfile.contents = contents
//        dotfile.dependencies = extractDependencies(from: contents)
//    }
//}

//let logger = Logger(label: "com.dotfiles.client")
//struct dotfiles3: ParsableCommand {
//
//
//
//    static let configuration = CommandConfiguration(
//        abstract: "Un programa que maneja archivos de configuración de punto."
//    )
//
//    @Option(help: "El nombre del archivo de configuración.")
//    var filename: String?
//
//    @Option(help: "El contenido del archivo de configuración.")
//    var contents: String?
//
//    func run() throws {
//
//        do {
//            try main()
//        } catch let error as ProgramInstallationError {
//            logger.error("Error installing program: \(error.localizedDescription)")
//        } catch {
//            logger.error("Unexpected error: \(error.localizedDescription)")
//        }
//
////        if let filename = filename {
////            if let contents = contents {
////                let dotfile = Dotfile(name: filename, contents: contents)
////                try Dotfile.saveDotfile(dotfile)
////                print("Archivo guardado: \(filename)")
////            } else {
////                let dotfile = try Dotfile.loadDotfile(name: filename)
////                print(dotfile.contents)
////            }
////        } else {
////            throw ValidationError("Se debe proporcionar un nombre de archivo.")
////        }
//    }
//
//    func main() throws {
//
//        let configFilePath = "~/dotfiles/config.yml"
//        let programRepository = InMemoryProgramRepository()
//        let dotfileRepository = InMemoryDotfileRepository()
//        let configLoader = ConfigLoader(programRepository: programRepository, dotfileRepository: dotfileRepository)
//
//        let config = try configLoader.loadConfig(configFilePath: configFilePath)
//
//        let programInstaller = ProgramInstaller(programRepository: programRepository, dotfileRepository: dotfileRepository)
//
//
//        let programService = ProgramService(programInstaller: programInstaller, programRepository: programRepository)
//
//        for program in config.programs {
//            try programService.installProgram(program: Program(name: program.name, installCommand: ""))
//        }
//
//        logger.info("Installation completed successfully.")
//    }
//
//}
//
//dotfiles3.main()


import ArgumentParser
import Logging

struct DotfilesPipelineCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "dotfiles",
        abstract: "My command-line tool",
        subcommands: [InstallCommand.self, UpdateCommand.self, UninstallCommand.self])
    
    @OptionGroup var loggingOptions: LoggingOptions
    
    mutating func run() throws {
        LoggingSystem.bootstrap(loggingOptions.bootstrap)
    }
}

struct LoggingOptions: ParsableArguments {
    var logLevel: Logger.Level = .info
    
    @Flag(name: .long, help: "Enable debug logging.")
    var debugLogging = false
    
    var bootstrap: ((String) -> LogHandler) {
        if debugLogging {
            return { label in
                var handler = StreamLogHandler.standardOutput(label: label)
                handler.logLevel = self.logLevel
                return handler
            }
        } else {
            return { label in
                var handler = StreamLogHandler.standardOutput(label: label)
                handler.logLevel = self.logLevel
                return handler
            }
        }
    }
}





DotfilesPipelineCommand.main()
