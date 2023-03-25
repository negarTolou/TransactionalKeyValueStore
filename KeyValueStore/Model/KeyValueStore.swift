//
//  KeyValueStore.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 23.03.23.
//

class KeyValueStore: KeyValueStoreProtocol {
    private var data: [String: String] = [:]
    private var transactions: [[String: String]] = []

    func set(key: String, value: String) {
        data[key] = value
    }

    func get(key: String) -> String? {
        return data[key]
    }

    func delete(key: String) {
        data[key] = nil
    }

    func count(value: String) -> Int {
        return data.values.filter { $0 == value }.count
    }

    func beginTransaction() {
        transactions.append(data)
    }

    func commitTransaction() {
        if !transactions.isEmpty {
            transactions = []
        }
    }

    func rollbackTransaction() {
        if let previousData = transactions.popLast() {
            data = previousData
        }
    }
}
