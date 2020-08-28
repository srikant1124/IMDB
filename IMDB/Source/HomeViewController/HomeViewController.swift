//
//  HomeViewController.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/7/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = MovieListViewModel()
    // Table view getting reload automatically ??????
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovies { result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movieViewModel = viewModel.movieAtIndexPat(indexPath: indexPath)
        cell.configureCell(viewModel: movieViewModel)
        return cell
    }
}
