
import Terminal

@main
public struct dotfiles {
    public private(set) var text = "Hello, World!"
    
    public private(set) static var terminal: Terminal = Terminal()

    public static func main() {
        print(terminal.shell.host("https://swiftzone.dev"))
        for file in terminal.shell.ls("-la","~/").split(separator: "\n") {
            if file.contains("dotfiles") {
                for line in terminal.shell.ls("~/dotfiles/.config").split(separator: "\n") {
                    print(line)
                }
            }
//            print("dir:", file.contains("dotfiles"))
        }
        
        let swiftVersion = terminal.shell.swift("--version")
        print(swiftVersion.split(separator: "\n").first ?? "")
        // Apple Swift version 5.0-dev (LLVM fe02928dd1, Clang 8836e4e85c, Swift 468f5b0530)

        print(terminal.shell.opt.homebrew.bin.python3("-c", "'print(13 + 37)'"))
        
//        print(dotfiles().text)
    }
}
