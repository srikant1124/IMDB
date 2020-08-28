//
//  SessionObjectStore.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/8/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

class SessionObjectStore {
    static let share = SessionObjectStore()
    private var user: User?
    
    func setUser(_ user: User) {
        self.user = user
    }
}
