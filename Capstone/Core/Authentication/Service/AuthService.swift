//
//  AuthService.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

let AuthService = _AuthService()
class _AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.fetchCurrentUser()
//            print("DEBUG: Sign in User \(result.user.uid)")
        } catch {
            print("DEBUG: Faild to create user \(error.localizedDescription)")

        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username:String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(email: email, fullname: fullname, username: username, id: result.user.uid)
            
//            print("DEBUG: Create User \(result.user.uid)")
        } catch {
            print("DEBUG: Faild to create user \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // sign out on backend
        self.userSession = nil
        UserService.resetUser() // Set User Object to nil
    }
    
    @MainActor
    private func uploadUserData(email: String,
                                fullname: String,
                                username:String,
                                id: String) async throws {
        
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.currentUser = user
    }
    
}
