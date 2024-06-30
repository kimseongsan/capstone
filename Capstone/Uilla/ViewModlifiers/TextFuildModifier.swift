//
//  ThreadsTextFuildModifier.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/12/24.
//

import SwiftUI

struct ThreadsTextFuildModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal,24)
    }
}

extension TextField {
    func threadsTextFuildModifier() -> some View {
        self.modifier(ThreadsTextFuildModifier())
    }
}

extension SecureField {
    func threadsTextFuildModifier() -> some View {
        self.modifier(ThreadsTextFuildModifier())
    }
}
