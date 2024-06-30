//
//  ThreadsButtonModifier.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/12/24.
//

import SwiftUI

struct ThreadsButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: UIScreen.main.bounds.width - 40, height: 44)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

extension Text {
    func threadsButtonModifier() -> some View {
        self.modifier(ThreadsButtonModifier())
    }
}
