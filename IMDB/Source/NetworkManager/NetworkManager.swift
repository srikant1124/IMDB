//
//  NetworkManager.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/10/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation
import UIKit

typealias MoviesResponseHandler = (Swift.Result<Movies, Error>) -> Void

class NetworkManager {
    static let share = NetworkManager()
    let session = URLSession.shared
    var items = [String]()
    
    var id = ""
    
    func fetchMvies(completion: @escaping MoviesResponseHandler) {
        guard let url = URL(string: NetworkAppValues.API.fetchMoviesURL) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = NetworkAppValues.MethodType.GET
        request.addValue(NetworkAppValues.MethodValues.applicationJsonVaue,
                         forHTTPHeaderField: NetworkAppValues.MethodValues.ContentType)
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let jsonData = data,
                let movies = try? decoder.decode(Movies.self, from: jsonData) else {
                    print("Parsing Error")
                    return
            }
            completion(.success(movies))
            
        }
        task.resume()
        
        var index = 0
        for each in items {
            if each == id {
                print(index)
                break
            }
            index += 1
        }
    }
    
    func downloadImage(posterPath: String, completion: @escaping (UIImage?) -> Void) {
        let finalUrl = "\(NetworkAppValues.API.imagePath)\(posterPath)"
        guard let url = URL(string: finalUrl) else {
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let imageData = data else {
                return
            }
            let image = UIImage(data: imageData)
            completion(image)
        }
        task.resume()
    }
}
