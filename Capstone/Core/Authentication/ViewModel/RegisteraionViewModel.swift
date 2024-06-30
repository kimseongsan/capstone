//
//  RegistrationViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""
    @Published  var fullname = ""
    @Published  var username = ""
    
    // Function to check if any field is empty
    func areFieldsEmpty() -> Bool {
        return email.isEmpty || password.isEmpty || fullname.isEmpty || username.isEmpty
    }
    
    @MainActor
    func createUser() async throws {
        try await AuthService.createUser(
            withEmail: email,
            password: password,
            fullname: fullname,
            username: username)
        print("Create User Here")
    }
}
