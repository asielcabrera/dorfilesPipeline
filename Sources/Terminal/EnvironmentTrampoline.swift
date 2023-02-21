//
//  EnvironmentTrampoline.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 2/20/23.
//

import Foundation

@dynamicMemberLookup
public struct EnvironmentTrampoline {
    
    public subscript(dynamicMember k: String) -> String? {
        return ProcessInfo.processInfo.environment[k]
    }
}
