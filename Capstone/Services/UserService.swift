//
//  UserService.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

let UserService = _UserService()
class _UserService {
    @Published var currentUser: User?
    
    init() {
        Task { try await fetchCurrentUser()}
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        //        print("DEBUG: User is \(user)")
    }
    
    func fetchUsers() async throws -> [User] {
        guard let currentUserId = Auth.auth().currentUser?.uid else {return [] }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({try? $0.data(as: User.self)})
        return users.filter({ $0.id != currentUserId })
    }
    
    func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    
    func resetUser() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUserId).updateData([ "profileImageUrl": imageUrl ])
        self.currentUser?.profileImageUrl = imageUrl
    }
}


