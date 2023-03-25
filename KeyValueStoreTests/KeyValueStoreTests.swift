//
//  KeyValueStoreTests.swift
//  KeyValueStoreTests
//
//  Created by Negar Tolou on 19.03.23.
//

import XCTest
@testable import KeyValueStore

class KeyValueStoreTests: XCTestCase {
    var keyValueStore: KeyValueStore!

    override func setUp() {
        super.setUp()
        keyValueStore = KeyValueStore()
    }

    override func tearDown() {
        keyValueStore = nil
        super.tearDown()
    }

    func testSetAndGet() {
        keyValueStore.set(key: "key1", value: "value1")
        XCTAssertEqual(keyValueStore.get(key: "key1"), "value1")
    }

    func testDelete() {
        keyValueStore.set(key: "key1", value: "value1")
        keyValueStore.delete(key: "key1")
        XCTAssertNil(keyValueStore.get(key: "key1"))
    }

    func testCount() {
        keyValueStore.set(key: "key1", value: "value1")
        keyValueStore.set(key: "key2", value: "value1")
        keyValueStore.set(key: "key3", value: "value2")
        XCTAssertEqual(keyValueStore.count(value: "value1"), 2)
    }

    func testBeginAndCommitTransaction() {
        keyValueStore.set(key: "key1", value: "value1")
        keyValueStore.set(key: "key2", value: "value2")

        keyValueStore.beginTransaction()
        keyValueStore.set(key: "key1", value: "newValue1")
        keyValueStore.set(key: "key3", value: "value3")
        keyValueStore.commitTransaction()

        XCTAssertEqual(keyValueStore.get(key: "key1"), "newValue1")
        XCTAssertEqual(keyValueStore.get(key: "key2"), "value2")
        XCTAssertEqual(keyValueStore.get(key: "key3"), "value3")
    }
    
    func testTransactions() {
        keyValueStore.set(key: "key1", value: "value1")
        keyValueStore.beginTransaction()
        keyValueStore.set(key: "key1", value: "value2")
        keyValueStore.rollbackTransaction()
        XCTAssertEqual(keyValueStore.get(key: "key1"), "value1")
    }
}
