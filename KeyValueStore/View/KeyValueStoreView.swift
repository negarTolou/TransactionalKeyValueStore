//
//  KeyValueStoreView.swift
//  KeyValueStore
//
//  Created by Negar Tolou on 23.03.23.
//

import SwiftUI

struct KeyValueStoreView: View {
    @StateObject var viewModel: KeyValueStoreViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Command:")
                
                Picker(selection: $viewModel.command, label: Text("Command")) {
                    ForEach(viewModel.commands, id: \.self) { command in
                        Text(command)
                    }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Text("Key:")
                TextField("Enter key", text: $viewModel.key)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Value:")
                TextField("Enter value", text: $viewModel.value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button {
                viewModel.processInput()
            } label: {
                Text("Submit")
                    .padding(.all, 8)
            }
            .foregroundColor(Color.white)
            .background(Color(.systemBlue))
            .cornerRadius(4)
            
            TextEditor(text: $viewModel.output)
                .disabled(true)
                .padding()
                .background(Color(.lightGray))
                .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.isError, content: {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        })
        .alert(isPresented: $viewModel.showConfirmation, content: {
            Alert(
                title: Text("Confirmation"),
                message: Text("Are you sure you want to perform \(viewModel.command)?"),
                primaryButton: .destructive(Text("Yes")) {
                    viewModel.pendingAction = viewModel.executeCommand
                    viewModel.pendingAction?()
                    viewModel.pendingAction = nil
                    viewModel.showConfirmation = false
                },
                secondaryButton: .cancel {
                    viewModel.pendingAction = nil
                    viewModel.showConfirmation = false
                }
            )
        })
    }
}

struct KeyValueStoreView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyValueStoreViewModel(store: KeyValueStore())
        viewModel.output = "Test output"
        return KeyValueStoreView(viewModel: viewModel)
    }
}

