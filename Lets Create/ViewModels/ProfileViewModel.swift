//
//  ProfileViewModel.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/1/21.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
