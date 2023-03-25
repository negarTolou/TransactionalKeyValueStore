//
//  CommandProcessorTests.swift
//  KeyValueStoreTests
//
//  Created by Negar Tolou on 25.03.23.
//

import XCTest
@testable import KeyValueStore

class CommandProcessorTests: XCTestCase {
    var keyValueStore: KeyValueStore!
    var commandProcessor: CommandProcessor!

    override func setUp() {
        super.setUp()
        keyValueStore = KeyValueStore()
        commandProcessor = CommandProcessor(store: keyValueStore)
    }

    override func tearDown() {
        commandProcessor = nil
        keyValueStore = nil
        super.tearDown()
    }

    func testSetCommand() {
        let result = commandProcessor.processCommand(command: "SET", key: "key1", value: "value1")
        XCTAssertEqual(result, .success("Set key1 to value1"))
    }

    func testGetCommand() {
        keyValueStore.set(key: "key1", value: "value1")
        let result = commandProcessor.processCommand(command: "GET", key: "key1", value: "")
        XCTAssertEqual(result, .success("Value for key1: value1"))
    }

    func testDeleteCommand() {
        keyValueStore.set(key: "key1", value: "value1")
        let result = commandProcessor.processCommand(command: "DELETE", key: "key1", value: "")
        XCTAssertEqual(result, .success("Deleted key1"))
    }

    func testCountCommand() {
        keyValueStore.set(key: "key1", value: "value1")
        keyValueStore.set(key: "key2", value: "value1")
        keyValueStore.set(key: "key3", value: "value2")
        let result = commandProcessor.processCommand(command: "COUNT", key: "", value: "value1")
        XCTAssertEqual(result, .success("Number of keys with value value1: 2"))
    }

    func testBeginCommand() {
        let result = commandProcessor.processCommand(command: "BEGIN", key: "", value: "")
        XCTAssertEqual(result, .success("Transaction started"))
    }

    func testCommitCommand() {
        keyValueStore.beginTransaction()
        keyValueStore.set(key: "key1", value: "value1")
        let result = commandProcessor.processCommand(command: "COMMIT", key: "", value: "")
        XCTAssertEqual(result, .success("Transaction committed"))
    }

    func testRollbackCommand() {
        keyValueStore.beginTransaction()
        keyValueStore.set(key: "key1", value: "value1")
        let result = commandProcessor.processCommand(command: "ROLLBACK", key: "", value: "")
        XCTAssertEqual(result, .success("Transaction rolled back"))
    }

    func testInvalidCommand() {
        let result = commandProcessor.processCommand(command: "INVALID_COMMAND", key: "key1", value: "value1")
        XCTAssertEqual(result, .failure(.invalidCommand))
    }

    func testGetKeyNotFound() {
        let result = commandProcessor.processCommand(command: "GET", key: "nonExistentKey", value: "")
        XCTAssertEqual(result, .failure(.keyNotFound))
    }

    func testSetEmptyKey() {
        let result = commandProcessor.processCommand(command: "SET", key: "", value: "value1")
        XCTAssertEqual(result, .failure(.invalidCommand))
    }

    func testDeleteEmptyKey() {
        let result = commandProcessor.processCommand(command: "DELETE", key: "", value: "")
        XCTAssertEqual(result, .failure(.invalidCommand))
    }

}
