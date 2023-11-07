//
//  Procedure.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import Terminal
import Logging

public protocol Procedure {
    static var terminal: Terminal { get set }
    static var logger: Logger { get set }
    static func main()
}

