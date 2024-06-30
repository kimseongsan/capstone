import SwiftUI

struct DetailView: View {
    @StateObject var viewModel : DetailViewModel
    let thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        self._viewModel = StateObject(wrappedValue: DetailViewModel(thread: thread))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircleProfileImageView(user: thread.user, size: .small)
                    
                    Text(thread.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(thread.timestamp.timestampString())
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray3))
                    
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.darkGray))
                    })
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(thread.caption)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
                .padding(.vertical)
            
            LazyVStack {
                ForEach(viewModel.replies) { reply in
                    ThreadReplyCell(reply: reply)
                }
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .navigationTitle("정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(thread: dev.thread)
}
