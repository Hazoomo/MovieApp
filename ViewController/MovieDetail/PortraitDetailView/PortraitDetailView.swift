//
//  PortraitDetailView.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 5/19/19.
//  Copyright © 2019 24i. All rights reserved.
//

import UIKit
protocol PortrailViewDelegate : class {
    func watchTrailerFromPortrait()
}
class PortraitDetailView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    weak var delegate :PortrailViewDelegate?
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
        
        Bundle.main.loadNibNamed("PortraitDetailView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
       
    }
    
    
    @IBAction func watchNow(_ sender: Any) {
        self.delegate?.watchTrailerFromPortrait()
    }
}
