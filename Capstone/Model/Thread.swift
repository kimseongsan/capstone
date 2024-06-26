//
//  Thread.swift
//  Threads Clone
//
//  Created by Garrett Hanberg on 9/5/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var informationId: String?
    
    let ownerUid: String
    let caption: String
    var likes: Int
    let timestamp: Timestamp
    
    var id: String {
        return informationId ?? NSUUID().uuidString
    }
    
    var user: User?
}
