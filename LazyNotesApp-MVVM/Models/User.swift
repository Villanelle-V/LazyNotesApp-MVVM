//
//  User.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-21.
//

import Foundation

struct User {
    let login: String
    let password: String
    
    init(with user: UserMO) {
        self.login = user.login
        self.password = user.password
    }
}
