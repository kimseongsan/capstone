//
//  ContentViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation
import Combine
import Firebase

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellable: AnyCancellable?

    init() {
        setUpSubscribers()
    }
    
    private func setUpSubscribers(){
        cancellable = AuthService.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
    }
}
