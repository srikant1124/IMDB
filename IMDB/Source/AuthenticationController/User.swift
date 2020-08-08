//
//  User.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/8/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

protocol UserProperty {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var mailId: String? { get set }
    var password: String? { get set }
    var conformPassword: String? { get set }
}

struct User: UserProperty {
    var mailId: String?
    var firstName: String?
    var lastName: String?
    var password: String?
    var conformPassword: String?
}
