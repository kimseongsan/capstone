//
//  Thread.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Thread : Identifiable, Codable, Hashable {
    @DocumentID var threadId: String? // required to be optional
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var replyCount: Int
    
    var didLike: Bool? = false
    
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
}
