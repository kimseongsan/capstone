//
//  ProfileThreadFilter.swift
//  Threads Clone
//
//  Created by Garrett Hanberg on 9/3/23.
//

import Foundation

enum ProfileFilter: Int, CaseIterable, Identifiable {
    case information
    
    var title: String {
        switch self {
        case .information: return "정보"
        }
    }
    
    var id: Int { return self.rawValue }
}
