//
//  ViewController.swift
//  SFSegmentControl
//
//  Created by Serge Nanaev on 05.01.17.
//  Copyright © 2017 Serge Nanaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SFSegmentControlDelegate {

    @IBOutlet weak var sfSegmentControl: SFSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sfSegmentControl.delegate = self
        sfSegmentControl.addSegment(withNormalTitle: "4", andSelectedTitle: "4 days")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectSegmentAtIndex(index: Int) {
        print("New selected segment \(index)")
    }


}

