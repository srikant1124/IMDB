//
//  MovieTableViewCell.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/15/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ratingView: UIImageView!
    @IBOutlet weak var save: UIButton!
    // Need a caching mechanisim
    func configureCell(viewModel: MovieViewModel) {
        title.text = viewModel.title
        overView.text = viewModel.overView
        CachingUtility.share.setPoster(url: viewModel.posterURL, posterView: poster)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
    }
}
