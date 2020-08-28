//
//  MovieListViewModel.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/10/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewModel {
    
    private var movies: Movies!
    var networkManager = NetworkManager.share

    func getMovies(completion: @escaping MoviesResponseHandler) {
        networkManager.fetchMvies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print("Error = \(error.localizedDescription)")
            }
            completion(result)
        }
    }
    
    func moviesCount() -> Int {
        guard let movieList = movies else {
            return 0
        }
        return movieList.results.count
    }
    
    func movieAtIndexPat(indexPath: IndexPath) -> MovieViewModel {
        let movie = movies.results[indexPath.row]
        return MovieViewModel(movie: movie)
    }
}

class CachingUtility {
    static let share = CachingUtility()
    var imageDict = [String: UIImage]()
    var imageCallDict = [String: Bool]()

    func setPoster(url: String, posterView: UIImageView) {
        guard let image = imageDict[url] else {
            guard imageCallDict[url] != nil else {
                imageCallDict[url] = true
                NetworkManager.share.downloadImage(posterPath: url) { image in
                    DispatchQueue.main.async {
                        self.imageDict[url] = image
                        posterView.image = image
                        posterView.isHidden = false
                    }
                }
                return
            }
            return
        }
        posterView.isHidden = false
        posterView.image = image
    }
}
