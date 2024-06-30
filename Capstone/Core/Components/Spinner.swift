//
//  Spinner.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import SwiftUI

struct Spinner: View {
    let loadingText: String?
    
    var body: some View {
        VStack (alignment:.center, spacing: 8){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.black)
            
            if loadingText != nil {
                Text(loadingText ?? "")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            
        }
        .frame(maxWidth: 100, maxHeight: 100)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

#Preview {
    Spinner(loadingText: nil)
}
