import SwiftUI

struct ThreadCell: View {
    let thread: Thread
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircleProfileImageView(user: thread.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                    }
                    
                    Text(thread.caption)
                        .font(.footnote)
                        .lineLimit(isExpanded ? nil : 3)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    
                    if !isExpanded && shouldShowExpandButton {
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text("더 보기")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    } else if isExpanded {
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text("접기")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.white))  // 밝은 배경색
            .cornerRadius(10)
            .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 5)  // 밝은 그림자 색상
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var shouldShowExpandButton: Bool {
        let textHeight = (thread.caption as NSString).boundingRect(
            with: CGSize(width: UIScreen.main.bounds.width - 32, height: .infinity),
            options: [.usesLineFragmentOrigin],
            attributes: [.font: UIFont.preferredFont(forTextStyle: .subheadline)],
            context: nil
        ).height
        
        return textHeight > 60
    }
}

#Preview {
    ThreadCell(thread: dev.thread)
}
