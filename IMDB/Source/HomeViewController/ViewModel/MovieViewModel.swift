//
//  MovieViewModel.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/10/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

class MovieViewModel {
    private var movie: Movie!
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var overView: String {
        return movie.overview
    }
    
    var posterURL: String {
        return movie.poster_path
    }
}
