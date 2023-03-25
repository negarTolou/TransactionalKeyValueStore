//
//  ContentView.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 19.03.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let keyValueStore = KeyValueStore()
        let viewModel = KeyValueStoreViewModel(store: keyValueStore)
        
        KeyValueStoreView(viewModel: viewModel)
    }
}
