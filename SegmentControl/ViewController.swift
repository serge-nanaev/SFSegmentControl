//
//  ViewController.swift
//  SegmentControl
//
//  Created by Serge Nanaev on 20.08.16.
//  Copyright © 2016 Serge Nanaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var mySegmentControl: MySegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mySegmentControl.addSegment(withNormalTitle: "zero", andSelectedTitle: "zeroSelected")
        mySegmentControl.addSegment(withNormalTitle: "first", andSelectedTitle: "firstSelected")
        mySegmentControl.addSegment(withNormalTitle: "second", andSelectedTitle: "secondSelected")

        mySegmentControl.selectedIndex = 0
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addButton(sender: AnyObject) {
        mySegmentControl.insertSegmentAtIndex(3, withNormalTitle: "new", andSelectedTitle: "newSelected")
        //mySegmentControl.removeSegmentAtIndex(1)
    }
    
    @IBAction func mySegmenvtValueChanged(sender: AnyObject) {
        guard let mySegmentControl = sender as? MySegmentControl else { return }
        
        resultLabel.text = "Selected index: \(mySegmentControl.selectedIndex)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

