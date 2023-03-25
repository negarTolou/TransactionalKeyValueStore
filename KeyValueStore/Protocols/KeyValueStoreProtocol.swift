//
//  KeyValueStoreProtocol.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 23.03.23.
//

protocol KeyValueStoreProtocol {
    func set(key: String, value: String) throws
    func get(key: String) throws -> String?
    func delete(key: String) throws
    func count(value: String) throws -> Int
    func beginTransaction() throws
    func commitTransaction() throws
    func rollbackTransaction() throws
}

