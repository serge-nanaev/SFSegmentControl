//
//  SFSelectorView.swift
//  SFSegmentControl
//
//  Created by Serge Nanaev on 05.01.17.
//  Copyright © 2017 Serge Nanaev. All rights reserved.
//

import UIKit

class SFSelectorView: UILabel {
    
    override var frame: CGRect {
        didSet {
            makeRound()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        self.backgroundColor = Constants.defaultSelectorColor
        self.textColor = Constants.defaultSelectorTitleColor
        self.font = Constants.defaultFont
        self.textAlignment = .center
    }
    
    fileprivate func makeRound() {
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height / 2
    }
}
