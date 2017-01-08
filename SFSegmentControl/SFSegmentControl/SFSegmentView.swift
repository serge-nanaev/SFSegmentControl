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
        
        self.textAlignment = NSTextAlignment.center
        self.textColor = Constants.defaultTitleColor
        self.font = font
        self.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
