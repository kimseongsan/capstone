//
//  CreateThreadViewModel.swift
//  Threads Clone
//
//  Created by Garrett Hanberg on 9/5/23.
//

import Firebase

class CreateViewModel: ObservableObject {
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let thread = Thread(ownerUid: uid, caption: caption, likes: 0, timestamp: Timestamp())
        try await CapService.uploadinformation(thread)
    }
}
