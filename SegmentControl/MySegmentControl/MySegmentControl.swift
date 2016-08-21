//
//  MySegmentControl.swift
//  SegmentControl
//
//  Created by Serge Nanaev on 20.08.16.
//  Copyright © 2016 Serge Nanaev. All rights reserved.
//

import UIKit


@IBDesignable class MySegmentControl: UIControl {
    
    //MARK: Setup for IB
    override func prepareForInterfaceBuilder() {
        segmentsStings = [("Segment 1", "S Segment 1"),
                          ("Segment 2", "S Segment 2")]
        selectedIndex = 0
    }
    
    //MARK: @IBInspectable
    @IBInspectable var normalTitleColor: UIColor = UIColor.redColor() {
        didSet {
            for segment in segments {
                segment.normalTitleColor = normalTitleColor
            }
        }
    }
    
    @IBInspectable var selectedTitleColor: UIColor = UIColor.blueColor() {
        didSet {
            for segment in segments {
                segment.selectedTitleColor = selectedTitleColor
            }
        }
    }
    
    @IBInspectable var normalBackgroundColor: UIColor = UIColor.blueColor() {
        didSet {
            for segment in segments {
                segment.normalBackgroundColor = normalBackgroundColor
            }
        }
    }
    
    @IBInspectable var selectedBackgroundColor: UIColor = UIColor.redColor() {
        didSet {
            for segment in segments {
                segment.selectedBackgroundColor = selectedBackgroundColor
            }
        }
    }
    
    @IBInspectable var highligtedColor: UIColor = UIColor.darkGrayColor() {
        didSet {
            for segment in segments {
                segment.highligtedColor = highligtedColor
            }
        }
    }
    
    //MARK: Data
    
    private var segmentsStings: [(normal: String, selected: String)] = [] {
        didSet {
            for segment in segments {
                segment.removeFromSuperview()
            }
            segments.removeAll()
            
            for (index, newSegmentData) in segmentsStings.enumerate() {
                
                let newSegment = SegmentView()
                newSegment.normalTitle = newSegmentData.normal
                newSegment.selectedTitle = newSegmentData.selected
                newSegment.normalBackgroundColor = normalBackgroundColor
                newSegment.selectedBackgroundColor = selectedBackgroundColor
                newSegment.normalTitleColor = normalTitleColor
                newSegment.selectedTitleColor = selectedTitleColor
                newSegment.highligtedColor = highligtedColor
                newSegment.index = index
                
                if selectedIndex == index {
                    newSegment.setSelected(true)
                }
                
                newSegment.didSelectSegment = { [weak self] segment in
                    self?.selectedIndex = segment.index
                }
                
                self.addSubview(newSegment)
                segments.append(newSegment)
            }
            
            self.layoutSubviews()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            
            if oldValue < segments.count {
                segments[oldValue].setSelected(false)
            }
            if selectedIndex < segments.count {
                segments[selectedIndex].setSelected(true)
                self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
            }
        }
    }
    
    //MARK: SegmentViews
    private var segments: [SegmentView] = []
    
    
    @objc private func segmentTapped(sender: UIButton) {
        selectedIndex = sender.tag
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.width
        
        let avalibleWidthForButton = width / CGFloat(segments.count)
        
        for (index, segment) in segments.enumerate() {
            segment.frame = CGRect(x: CGFloat(index) * avalibleWidthForButton,
                                   y: 0,
                                   width: avalibleWidthForButton,
                                   height: self.bounds.height)
        }
    }
    
    //MARK: Controls
    
    func addSegment(withNormalTitle normalTitle: String, andSelectedTitle selectedTitle: String) {
        segmentsStings.append((normal: normalTitle, selected: selectedTitle))
    }
    
    func insertSegmentAtIndex(index: Int,
                             withNormalTitle normalTitle: String,
                             andSelectedTitle selectedTitle: String) {
        
        guard segmentsStings.count >= index  else { return }
        
        segmentsStings.insert((normal: normalTitle, selected: selectedTitle), atIndex: index)
        
        if index <= selectedIndex {
            let newSelectedIndex = selectedIndex + 1
            selectedIndex = newSelectedIndex
        }
    }
    
    func removeSegmentAtIndex(index: Int) {
        
        guard segmentsStings.count > index  else { return }
        
        segmentsStings.removeAtIndex(index)
        
        if index < selectedIndex {
            let newSelectedIndex = selectedIndex - 1
            selectedIndex = newSelectedIndex
        } else if index == selectedIndex {
            selectedIndex = 0
        }
    }
}
