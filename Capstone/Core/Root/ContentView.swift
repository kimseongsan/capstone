//
//  ContentView.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                CapTabView()
                   
            } else {
                LoginView()
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
