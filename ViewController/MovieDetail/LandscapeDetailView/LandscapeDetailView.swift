//
//  LandscapeDetailView.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 5/19/19.
//  Copyright © 2019 24i. All rights reserved.
//

import UIKit
protocol LandscapeViewDelegate : class {
    func watchTrailerFromLandscape()
}
class LandscapeDetailView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    weak var delegate :LandscapeViewDelegate?
    
    //MARK: - view cycle
    
    override init (frame : CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        
    }
    
    private func commonInit()
    {
        
        Bundle.main.loadNibNamed("LandscapeDetailView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        
    }
    
    
    @IBAction func watchNow(_ sender: Any) {
        self.delegate?.watchTrailerFromLandscape()
    }
}
