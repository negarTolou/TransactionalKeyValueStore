//
//  Command.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 23.03.23.
//

enum Command {
    case set(key: String, value: String)
    case get(key: String)
    case delete(key: String)
    case count(value: String)
    case beginTransaction
    case commitTransaction
    case rollbackTransaction
}

enum CommandResult {
    case success(String)
    case failure(String)
}
