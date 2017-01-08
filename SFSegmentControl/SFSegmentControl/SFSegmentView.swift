//
//  SFSegmentView.swift
//  SFSegmentControl
//
//  Created by Serge Nanaev on 20.08.16.
//  Copyright © 2016 Serge Nanaev. All rights reserved.
//

import UIKit

@IBDesignable class SFSegmentView: UILabel {
    
    
    //MARK:- Inits
    
    init() {
        super.init(frame: CGRect.zero)
        self.initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetup()
    }
    
    fileprivate func initialSetup() {
        self.textAlignment = NSTextAlignment.center
        self.textColor = Constants.defaultTitleColor
        self.font = Constants.defaultFont
        self.backgroundColor = UIColor.clear
    }
}
