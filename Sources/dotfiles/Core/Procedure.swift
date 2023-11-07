//
//  Procedure.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import Terminal


public protocol Procedure {
    static var terminal: Terminal { get set }
    static func main()
}

