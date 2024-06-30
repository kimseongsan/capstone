//
//  ThreadService.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self)})
    }
    
    /// wehen we user whereField we can not use order if we do we have to create an Endex in firebase firestor otherwise just use local sorted or filter to deal with the array.
    static func fetchCurrentUserThreads(by uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self)})
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    
    static func fetchThread(threadId: String) async throws -> Thread {
        let snapshot = try await FirestoreConstants
            .ThreadCollection
            .document(threadId)
            .getDocument()
        
        return try snapshot.data(as: Thread.self)
    }
    
}


// MARK: - Likes

extension ThreadService {
    static func likeThread(_ thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadRef = FirestoreConstants.ThreadCollection.document(thread.id)
        let userRef = FirestoreConstants.UserCollection.document(uid)
        
        async let _ = try await threadRef.collection("thread-likes").document(uid).setData([:])
        async let _ = try await threadRef.updateData(["likes": thread.likes + 1])
        async let _ = try await userRef.collection("user-likes").document(thread.id).setData([:])
    }
    
    static func unlikeThread(_ thread: Thread) async throws {
        guard thread.likes > 0 else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadRef = FirestoreConstants.ThreadCollection.document(thread.id)
        let userRef = FirestoreConstants.UserCollection.document(uid)
        
        async let _ = try await threadRef.collection("thread-likes").document(uid).delete()
        async let _ = try await userRef.collection("user-likes").document(thread.id).delete()
        async let _ = try await threadRef.updateData(["likes": thread.likes - 1])
    }
    
    static func cheackIfUserLikedThread(_ thread: Thread) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        let userRef = FirestoreConstants.UserCollection.document(uid)

        let snapshot = try await userRef.collection("user-likes").document(thread.id).getDocument()
        return snapshot.exists
    }

}

