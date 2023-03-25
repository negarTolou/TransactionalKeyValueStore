//
//  CommandProcessor.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 23.03.23.
//
class CommandProcessor {
    let store: KeyValueStoreProtocol

    init(store: KeyValueStoreProtocol) {
        self.store = store
    }

    func processCommand(command: String, key: String, value: String) -> Result<String, KeyValueStoreError> {
        do {
            switch command {
            case "SET":
                guard !key.isEmpty else {
                    return .failure(.invalidCommand)
                }
                do {
                    try store.set(key: key, value: value)
                    return .success("Set \(key) to \(value)")
                } catch {
                    return .failure(error as! KeyValueStoreError)
                }
            case "GET":
                guard !key.isEmpty else {
                    return .failure(.invalidCommand)
                }
                do {
                    if let value = try store.get(key: key) {
                        return .success("Value for \(key): \(value)")
                    } else {
                        return .failure(.keyNotFound)
                    }
                } catch {
                    return .failure(error as! KeyValueStoreError)
                }

            case "DELETE":
                guard !key.isEmpty else {
                    return .failure(.invalidCommand)
                }
                do {
                    try store.delete(key: key)
                    return .success("Deleted \(key)")
                } catch {
                    return .failure(error as! KeyValueStoreError)
                }

            case "COUNT":
                do {
                    let count = try store.count(value: value)
                    return .success("Number of keys with value \(value): \(count)")
                } catch {
                    return .failure(error as! KeyValueStoreError)
                }

            case "BEGIN":
                do {
                    try store.beginTransaction()
                    return .success("Transaction started")
                } catch {
                    return .failure(error as! KeyValueStoreError)
                }

            case "COMMIT":
                do {
                    try store.commitTransaction()
                    return .success("Transaction committed")
                } catch {
                    return .failure(.transactionError)
                }
            case "ROLLBACK":
                do {
                    try store.rollbackTransaction()
                    return .success("Transaction rolled back")
                } catch {
                    return .failure(error as! KeyValueStoreError)
                }

            default:
                return .failure(.invalidCommand)
            }
        }
    }
}
