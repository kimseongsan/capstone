//
//  CurrentProfileViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation
import Combine


class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellable: AnyCancellable?
    
    init() {
        setUpSubscribers()
    }
    
    private func setUpSubscribers(){
        cancellable = UserService.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            
            print("DEBUG: User in view model from combine is \(String(describing: user))")
        }
    }
}
