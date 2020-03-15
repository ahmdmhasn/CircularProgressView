//
//  ViewController.swift
//  CircularProgressViewDemo
//
//  Created by Ahmed M. Hassan on 3/15/20.
//  Copyright © 2020 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: CircleProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Create ProgressView programmatically
        let frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let progressView2 = CircleProgressView(frame: frame)
        progressView2.center = view.center
        view.addSubview(progressView2)
        /// Configure properties
        progressView2.lineColor = .blue
        progressView2.bgColor = UIColor.gray.withAlphaComponent(0.3)
        
        var value: CGFloat = 60
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            value -= 1
            progressView2.animate(to: value / 60)
            self.progressView.animate(to: 1 - value / 60)
        }
        
    }


}

