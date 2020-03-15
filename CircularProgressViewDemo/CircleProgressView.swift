//
//  CircleProgressView.swift
//  CircularProgressViewDemo
//
//  Created by Ahmed M. Hassan on 3/15/20.
//  Copyright © 2020 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {

    // MARK: - Properties
    @IBInspectable var bgColor: UIColor = UIColor.lightGray {
        didSet { trackLayer.strokeColor = bgColor.cgColor }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blue {
        didSet { shapeLayer.strokeColor = lineColor.cgColor }
    }
    
    @IBInspectable var lineWidth: CGFloat = 10 {
        didSet { [shapeLayer, trackLayer].forEach{ $0.lineWidth = lineWidth } }
    }
    
    private var fromValue = CGFloat.zero
    
    // MARK: - Variables
    private lazy var circularPath: UIBezierPath = {
        layoutIfNeeded()
        let startAngle = -CGFloat.pi / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(
            arcCenter: center,
            radius: min(bounds.width, bounds.height) / 2 - lineWidth,
            startAngle: startAngle,
            endAngle: startAngle + 2 * CGFloat.pi,
            clockwise: true
        )
        return path
    }()
    
    private lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = bgColor.cgColor
        layer.lineWidth = lineWidth
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        return layer
    }()
    
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = lineColor.cgColor
        layer.lineWidth = lineWidth
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.strokeEnd = 0
        return layer
    }()
    
    private lazy var basicAnimation: CABasicAnimation = {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = 1
        basicAnimation.fillMode = .both
        basicAnimation.isRemovedOnCompletion = false
        return basicAnimation
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    private func commitInit() {
        
        layer.addSublayer(trackLayer)
        
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Handlers
    /**
     Animate the circle view
     - parameter value: value from 0 to 1.
     */
    func animate(to value: CGFloat) {
        basicAnimation.fromValue = fromValue
        basicAnimation.toValue = value
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
        fromValue = value
    }
    
}
