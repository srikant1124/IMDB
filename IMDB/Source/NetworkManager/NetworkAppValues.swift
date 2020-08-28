//
//  NetworkAppValues.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/15/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

enum NetworkAppValues {
    enum API {
        static let imagePath = "https://image.tmdb.org/t/p/original"
        static let fetchMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=3f33babb9f20f966e8f53f68dac7eac5"
        static let getMovieURL = ""
    }
    enum MethodType {
        static let GET = "GET"
        static let POST = "POST"
        static let PUT = "PUT"
    }
    enum MethodValues {
        static let applicationJsonVaue = "application/json"
        static let ContentType = "Content-type"
    }
}
