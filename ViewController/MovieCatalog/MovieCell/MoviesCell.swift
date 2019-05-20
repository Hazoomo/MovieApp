//
//  MoviesCell.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 5/19/19.
//  Copyright © 2019 24i. All rights reserved.
//

import UIKit

class MoviesCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
