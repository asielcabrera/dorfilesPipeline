//
//  UpdateSettingProcedure.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 11/7/23.
//

import Terminal

public struct UpdateSettingProcedure: Procedure {
    public static var terminal = Terminal()
    
    public static func main() {
        let apps = ["Safari", "Finder", "Dock", "Mail", "SystemUIServer"]
        let commands = [
            "write NSGlobalDomain AppleShowAllExtensions -bool true",
            "write com.apple.Finder AppleShowAllFiles -bool false",
            "write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true",
            "write NSGlobalDomain AppleKeyboardUIMode -int 3",
            "write NSGlobalDomain AppleFontSmoothing -int 2",
            "write com.apple.dock autohide -bool true",
            "write com.apple.finder DisableAllAnimations -bool true",
            "write com.apple.finder ShowPathbar -bool true",
            "write com.apple.finder ShowStatusBar -bool true",
            "write com.apple.dock launchanim -bool false",
            "write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false",
            "write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true"
            
        ]
        
        print("Updating OSX settings")
        
        terminal.shell.chflags("nohidden ~/Library")
        allDefaults(commands)
        killall(apps)
    }
    
    public static func killall(_ apps: [String]) {
        for app in apps {
            terminal.shell.killall(app)
        }
    }
    
    public static func commandExec(_ command: String) {
        terminal.shell.defaults(command)
    }
    
    public static func allDefaults(_ commandsList: [String]) {
        for command in commandsList {
            commandExec(command)
        }
    }
}
