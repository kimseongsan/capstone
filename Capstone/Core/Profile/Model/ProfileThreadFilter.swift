//
//  ProfileThreadFilter.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    
    var title: String {
        switch self {
        case .threads:
            return "정보"
        }
    }
    
    var id: Int { return self.rawValue }
}
