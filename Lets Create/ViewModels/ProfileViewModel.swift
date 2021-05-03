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
class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    var creative: String
    
    init(uid:String, username:String,photoURL:URL, creative:String) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        self.creative = creative
    }
}

