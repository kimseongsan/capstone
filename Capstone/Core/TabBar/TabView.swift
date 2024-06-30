import SwiftUI

struct CapTabView: View {
    @State private var selectedTab = 1 // 가운데 탭을 기본 선택으로 설정
    @Namespace private var tabAnimation
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)
            
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .tag(1)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                }
                .tag(2)
        }
        .tint(.black)
    }
}

#Preview {
    CapTabView()
}
