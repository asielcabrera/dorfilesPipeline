//
//  Terminal.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 2/20/23.
//

import Foundation

public struct Terminal {
    public var shell:ShellTrampoline
    
    public init() {
        self.shell = ShellTrampoline()
    }
}



@dynamicCallable
@dynamicMemberLookup
public struct ShellPathTrampoline {
  
    let url : URL
    var fm  : FileManager { return FileManager.default }
  
    public subscript(dynamicMember key: String) -> ShellPathTrampoline {
        let url    = self.url.appendingPathComponent(key)
        var isDir  : ObjCBool = false
        let exists = fm.fileExists(atPath: url.path, isDirectory: &isDir)
        if exists && isDir.boolValue {
            let url = self.url.appendingPathComponent(key, isDirectory: true)
            return ShellPathTrampoline(url: url)
        }
        return ShellPathTrampoline(url: url)
    }
  
    var doesExist : Bool {
        return fm.fileExists(atPath: url.path)
    }
  
    var isDirectory : Bool {
        var isDir  : ObjCBool = false
        let exists = fm.fileExists(atPath: url.path, isDirectory: &isDir)
        return exists && isDir.boolValue
    }

    @discardableResult
    public func dynamicallyCall(withArguments arguments: [ String ])
         -> Process.FancyResult
    {
        func makeError(code: Int, info: String) -> Process.FancyResult {
            let error = "\(url.path): \(info)".data(using: .utf8) ?? Data()
            return Process.FancyResult(status: code, outputData: Data(),
                                       errorData: error)
        }
    
        guard doesExist else {
            return makeError(code: 1, info: "No such file or directory")
        }
        guard !isDirectory else {
            return makeError(code: 2, info: "is a directory")
        }
        guard fm.isExecutableFile(atPath: url.path) else {
            return makeError(code: 99, info: "Permission denied")
        }
        
        return Process.launch(at: url.path, with: arguments)
    }
}

@dynamicMemberLookup
public struct ShellTrampoline {
  
    public let root : ShellPathTrampoline
    public var url  : URL { return root.url }
  
    public init(url: URL = URL(fileURLWithPath: "/")) {
        self.root = ShellPathTrampoline(url: url)
    }
  
    public let env = EnvironmentTrampoline()
  
    public subscript(dynamicMember key: String) -> ShellPathTrampoline {
        let trampoline = root[dynamicMember: key]
        if trampoline.doesExist { return trampoline }
        return lookupInPATH(key) ?? trampoline
    }
  
    func lookupInPATH(_ k: String) -> ShellPathTrampoline? {
        let searchPath = (env.PATH ?? "/usr/bin").components(separatedBy: ":")
        
        let testURLs = searchPath.lazy.map { ( path: String ) -> URL in
            let testDirURL : URL
            if #available(macOS 10.11, *) {
                testDirURL = URL(fileURLWithPath: path, relativeTo: self.url)
            }
            else {
                testDirURL = URL(fileURLWithPath: path)
            }
            return testDirURL.appendingPathComponent(k)
        }
      
        let fm = FileManager.default
        for testURL in testURLs {
            let testPath = testURL.path
            var isDir    : ObjCBool = false
          
            if fm.fileExists(atPath: testPath, isDirectory: &isDir) {
                if !isDir.boolValue && fm.isExecutableFile(atPath: testPath) {
                    return ShellPathTrampoline(url: testURL)
                }
            }
        }
      
        return nil
    }
}
//import Foundation
//
//let homeDir = FileManager.default.homeDirectoryForCurrentUser
//let dotfileRepoDir = URL(fileURLWithPath: "~/dotfiles")
//
//let dotfiles = ["bashrc", "vimrc", "gitconfig", "ssh/config", "tmux.conf"]
//
//for dotfile in dotfiles {
//    let source = dotfileRepoDir.appendingPathComponent(dotfile)
//    let destination = homeDir.appendingPathComponent("." + dotfile)
//    
//    if FileManager.default.fileExists(atPath: destination.path) {
//        print("Backing up existing dotfile: \(destination.lastPathComponent)")
//        try FileManager.default.moveItem(at: destination, to: destination.appendingPathExtension("bak"))
//    }
//    
//    print("Creating symlink: \(destination.lastPathComponent)")
//    try FileManager.default.createSymbolicLink(at: destination, withDestinationURL: source)
//}
