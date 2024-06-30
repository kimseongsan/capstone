//
//  LoginViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""
    
    // Function to check if any field is empty
    func areFieldsEmpty() -> Bool {
        return email.isEmpty || password.isEmpty
    }
    
    @MainActor
    func login() async throws {
        try await AuthService.login(withEmail: email, password: password)
        print("Create User Here")
    }
}
