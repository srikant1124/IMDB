//
//  Movies.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/10/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

struct Movies: Codable {
    var results: [Movie]
    
    enum MovieListKey: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MovieListKey.self)
        self.results = try values.decode([Movie].self, forKey: .results)
    }
}
