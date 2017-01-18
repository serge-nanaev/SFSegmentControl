//
//  SFSegmentControl.swift
//  SFSegmentControl
//
//  Created by Serge Nanaev on 20.08.16.
//  Copyright © 2016 Serge Nanaev. All rights reserved.
//

import UIKit

fileprivate struct SFSegment {
    let title: String
    let selectedTitle: String
}

@IBDesignable class SFSegmentControl: UIView {
    
    //MARK:- Properties
    //MARK: @IBInspectable
    
    @IBInspectable var titleColor: UIColor = Constants.defaultTitleColor {
        didSet {
            self.segmentsViews.forEach { $0.textColor = titleColor }
        }
    }
    
    @IBInspectable var selectorTitleColor: UIColor = Constants.defaultSelectorTitleColor {
        didSet {
            self.selectorView.textColor = selectorTitleColor
        }
    }
    
    @IBInspectable var selectorColor: UIColor = Constants.defaultSelectorColor {
        didSet {
            self.selectorView.backgroundColor = selectorColor
        }
    }
    
    @IBInspectable var containerBackgroundColor: UIColor = Constants.defaultContainerBackgroundColor {
        didSet {
            self.backgroundColor = containerBackgroundColor
        }
    }
    
    @IBInspectable var containerBorderColor: UIColor = Constants.defaultContainerBorderColor {
        didSet {
            self.setupContainer()
        }
    }
    
    @IBInspectable var containerBorderWidth: CGFloat = Constants.defaultContainerBorderWidth {
        didSet {
            self.setupContainer()
        }
    }
    
    public var font: UIFont = Constants.defaultFont {
        didSet {
            self.segmentsViews.forEach { $0.font = font }
        }
    }
    
    public var delegate: SFSegmentControlDelegate?
    
    fileprivate var animationDuration = 0.2
    
    //MARK: Segments
    
    fileprivate var segments: [SFSegment] = [] {
        didSet {
            self.generateSegmentViews()
        }
    }

    fileprivate var segmentsViews: [SFSegmentView] = []
    fileprivate let selectorView = SFSelectorView()
    
    fileprivate (set) var selectedIndex: Int = 0
    
    //MARK:- Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Public methods
    
    func addSegment(withNormalTitle normalTitle: String, andSelectedTitle selectedTitle: String) {
        segments.append(SFSegment(title: normalTitle, selectedTitle: selectedTitle))
    }
    
    func insertSegmentAtIndex(_ index: Int,
                              withNormalTitle normalTitle: String,
                              andSelectedTitle selectedTitle: String) {
        
        segments.insert(SFSegment(title: normalTitle, selectedTitle: selectedTitle), at: index)
        
    }
    
    func removeSegmentAtIndex(_ index: Int) {
        
        segments.remove(at: index)
        
        if index < selectedIndex {
            let newSelectedIndex = selectedIndex - 1
            selectedIndex = newSelectedIndex
        } else if index == selectedIndex {
            selectedIndex = 0
        }
    }
    
    func selectSegmentAtIndex(index: Int) {
        self.selectedIndex = index
        
        let newPosition = (self.bounds.width / CGFloat(self.segments.count)) * CGFloat(index)

        UIView.animate(withDuration: animationDuration,
                       animations: {
            self.selectorView.frame.origin.x = newPosition
            self.selectorView.text = self.segments[index].selectedTitle
        })
        
        delegate?.didSelectSegmentAtIndex(index: index)
    }
    
    //MARK:- Setup
    
    fileprivate func setup() {
        self.addGestures()
        self.addInitialData()
        self.generateSegmentViews()
    }
    
    //Initial data for Preview
    fileprivate func addInitialData() {
        self.segments = [SFSegment(title: "1", selectedTitle: "1 day"),
                         SFSegment(title: "2", selectedTitle: "2 days"),
                         SFSegment(title: "3", selectedTitle: "3 days")]
        self.selectorView.text = segments.first!.selectedTitle
    }
    
    fileprivate func generateSegmentViews() {
        self.selectorView.removeFromSuperview()
        self.segmentsViews.forEach { $0.removeFromSuperview() }
        self.segmentsViews.removeAll()
        for segment in segments {
            let newSegmentView = SFSegmentView()
            newSegmentView.font = self.font
            newSegmentView.textColor = self.titleColor
            newSegmentView.text = segment.title
            self.addSubview(newSegmentView)
            segmentsViews.append(newSegmentView)
        }
        self.addSubview(selectorView)
    }
    
    fileprivate func setupContainer() {
        self.backgroundColor = self.containerBackgroundColor
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = self.containerBorderColor.cgColor
        self.layer.borderWidth = self.containerBorderWidth
    }
    
    //MARK: SegmentViews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupContainer()
        self.setFrames()

    }
    
    fileprivate func setFrames() {
        let width = self.bounds.width
        let avalibleWidthForButton = width / CGFloat(segmentsViews.count)
        
        for (index, segment) in segmentsViews.enumerated() {
            segment.frame = CGRect(x: CGFloat(index) * avalibleWidthForButton,
                                   y: 0,
                                   width: avalibleWidthForButton,
                                   height: self.bounds.height)
        }
        
        self.selectorView.frame = CGRect(x: CGFloat(self.selectedIndex) * avalibleWidthForButton,
                                         y: 0,
                                         width: avalibleWidthForButton,
                                         height: self.bounds.height)
    }
    
    //MARK:- Gestures
    
    fileprivate func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    @objc fileprivate func didTap(tapGesture: UITapGestureRecognizer) {
        self.selectNearestSegment(with: tapGesture)
    }
    
    fileprivate func selectNearestSegment(with gesture: UIGestureRecognizer) {
        let location = gesture.location(in: self)
        let index = self.getIndexFromPoint(point: location)
        self.selectSegmentAtIndex(index: index)
    }
    
    fileprivate func getIndexFromPoint(point: CGPoint) -> Int {
        let index = Int(point.x / self.selectorView.frame.width)
        guard index > 0 else { return 0 }
        guard index < segments.count else { return segments.count - 1}
        
        return index
    }
}
