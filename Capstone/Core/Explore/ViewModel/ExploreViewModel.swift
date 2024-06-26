import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""

    private var allUsers = [User]()  // 모든 사용자 데이터를 복사해두는 배열

    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.allUsers = try await UserService.fetchUsers()
        filterUsers()
    }

    // 검색어에 따라 사용자를 필터링하는 메서드
    private func filterUsers() {
        if searchText.isEmpty {
            users = allUsers
        } else {
            users = allUsers.filter { user in
                user.username.contains(searchText)
            }
        }
    }
}
