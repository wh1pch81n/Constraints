//
//  ViewController.swift
//  AutoLayout_SampleProject
//
//  Created by Derrick Ho on 1/16/18.
//  Copyright © 2018 Derrick Ho. All rights reserved.
//

import UIKit
import Constraint

class ViewController: UIViewController {

    var redView: UIView!
    var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView = UIView()
        redView.backgroundColor = UIColor.red
        
        blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        
        view.addSubview(redView)
        view.addSubview(blueView)
        
        () |-* 10 *-* redView *-* blueView.length(equalTo: 30) *-* 26 *-| ()
            *->> Constraint.Apply(to: view, direction: .horizontal)
        
    
        () |-* 20 *-* redView *-* 20 *-| ()
            *->> Constraint.Apply(to: view, direction: .vertical)
        () |-* 20 *-* blueView *-* 20 *-| ()
            *->> Constraint.Apply(to: view, direction: .vertical)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

