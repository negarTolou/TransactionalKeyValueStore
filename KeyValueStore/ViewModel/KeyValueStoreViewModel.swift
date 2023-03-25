//
//  KeyValueStoreViewModel.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 23.03.23.
//

import SwiftUI

class KeyValueStoreViewModel: ObservableObject {
    let store: KeyValueStoreProtocol
    let commandProcessor: CommandProcessor

    @Published var command: String = "SET"
    @Published var key: String = ""
    @Published var value: String = ""
    @Published var output: String = ""
    @Published var inTransaction: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var showConfirmation: Bool = false
    @Published var pendingAction: (() -> Void)?

    let commands = ["SET", "GET", "DELETE", "COUNT", "BEGIN", "COMMIT", "ROLLBACK"]

    init(store: KeyValueStoreProtocol) {
        self.store = store
        self.commandProcessor = CommandProcessor(store: store)
    }

    func processInput() {
        if command == "COMMIT" || command == "ROLLBACK" || command == "DELETE" {
            showConfirmation = true
            return
        }

        executeCommand()
    }

    func executeCommand() {
        switch commandProcessor.processCommand(command: command, key: key, value: value) {
        case .success(let result):
            output = result
            isError = false
            errorMessage = ""
        case .failure(let error):
            output = ""
            isError = true
            errorMessage = error.description
        }

        clearInputFields()
    }

    private func clearInputFields() {
        key = ""
        value = ""
    }
}

