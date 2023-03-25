//
//  ErrorHandler.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 24.03.23.
//

enum KeyValueStoreError: Error {
    case keyNotFound
    case invalidCommand
    case transactionError

    var description: String {
        switch self {
        case .keyNotFound:
            return "Key not found"
        case .invalidCommand:
            return "Invalid command"
        case .transactionError:
            return "Transaction error"
        }
    }
}
