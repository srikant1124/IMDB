//
//  Movie.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/10/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var title: String
    var overview: String
    var poster_path: String
    var id: Int
    
    enum MovieCodingKey: CodingKey {
        case title
        case overview
        case poster_path
        case id
    }
    
    init(from decode: Decoder) throws {
        let values = try decode.container(keyedBy: MovieCodingKey.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.overview = try values.decode(String.self, forKey: .overview)
        self.poster_path = try values.decode(String.self, forKey: .poster_path)
        self.id = try values.decode(Int.self, forKey: .id)
    }
}
