//
//  BrewProcedure.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import Terminal


public struct BrewProcedure: Procedure {
    public static var terminal = Terminal()
    
    public static func main() {
        if checkBrewIsInstalled() {
            InstallPackagesWithBrew()
        } else {
            InstallBrew()
        }
    }
    
    internal static func checkBrewIsInstalled() -> Bool  {
        // checking if brew is installed on this machine
        return terminal.shell.brew("--version").description.contains("Homebrew")
    }
    
    internal static func InstallBrew() {
        print("installing brew")
    }
    
    internal static func InstallPackagesWithBrew() {
        print("installing packages with brew")
    }
}
