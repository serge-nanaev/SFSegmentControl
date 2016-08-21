//
//  SegmentView.swift
//  SegmentControl
//
//  Created by Serge Nanaev on 20.08.16.
//  Copyright © 2016 Serge Nanaev. All rights reserved.
//

import UIKit

@IBDesignable class SegmentView: UIView {
    
    private var label: UILabel = UILabel()
    
    // Title
    var normalTitle: String? {
        didSet {
            self.label.text = self.normalTitle
            self.layoutSubviews()
        }
    }
    
    var selectedTitle: String?
    var index: Int = 0
    
    var normalBackgroundColor: UIColor = UIColor.blueColor() {
        didSet {
            if !isSelected {
                self.backgroundColor = normalBackgroundColor
            }
        }
    }
    var selectedBackgroundColor: UIColor = UIColor.redColor() {
        didSet {
            if isSelected {
                self.backgroundColor = selectedBackgroundColor
            }
        }
    }
    var highligtedColor: UIColor = UIColor.cyanColor()
    
    var normalTitleColor: UIColor = UIColor.redColor() {
        didSet {
            if !isSelected {
                self.label.textColor = normalTitleColor
            }
        }
    }
    
    var selectedTitleColor: UIColor = UIColor.blueColor() {
        didSet {
            if isSelected {
                self.label.textColor = selectedTitleColor
            }
        }
    }
    
    private(set) var isSelected: Bool = false
    
    var didSelectSegment: ((segment: SegmentView)->())?
    
    init() {
        
        super.init(frame: CGRectZero)

        self.label.textAlignment = NSTextAlignment.Center
        self.label.textColor = normalTitleColor
        self.backgroundColor = normalBackgroundColor
        self.addSubview(self.label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }
    
    // MARK: Selections
    func setSelected(selected: Bool) {
        self.isSelected = selected
        if selected == true {
            self.label.text = selectedTitle
            self.backgroundColor = selectedBackgroundColor
            self.label.textColor = selectedTitleColor
        }
        else {
            self.label.text = normalTitle
            self.backgroundColor = normalBackgroundColor
            self.label.textColor = normalTitleColor
        }
    }
    
    // MARK: Handle touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.isSelected == false {
            self.backgroundColor = highligtedColor
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.isSelected == false {
            self.didSelectSegment?(segment: self)
        }
    }
    
}
