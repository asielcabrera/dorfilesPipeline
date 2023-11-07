//
//  SymlinkPrecedure.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import Terminal
import Logging

public struct SymlinkPrecedure: Procedure {
    public static var terminal = Terminal()
    public static var logger = Logger(label: "com.shiroe.dotfiles.SymlinkPrecedure")
    public static func main() {
        logger.info("Creating symlinks")
    }
}
