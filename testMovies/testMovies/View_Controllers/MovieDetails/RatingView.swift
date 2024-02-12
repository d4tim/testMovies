//
//  RatingView.swift
//  testMovies
//
//  Created by Makar Grushka on 08.01.2024.
//

import UIKit

class RatingView: UIView {
    var rating: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let starCount = 5
        let starSize = rect.size.width / CGFloat(starCount)

        for i in 0..<starCount {
            let starRect = CGRect(x: CGFloat(i) * starSize, y: 0, width: starSize, height: rect.size.height)
            drawStar(in: context, inRect: starRect, withFill: Double(i) < rating)
        }
    }

    private func drawStar(in context: CGContext, inRect rect: CGRect, withFill fill: Bool) {
        let starPath = UIBezierPath()

        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let numberOfPoints = 5
        let starRadius: CGFloat = rect.width / 2
        let angle = (4 * .pi) / CGFloat(numberOfPoints * 2)

        starPath.move(to: CGPoint(x: centerX, y: 0))

        for i in 1...numberOfPoints * 2 {
            let radius = i % 2 == 0 ? starRadius : starRadius / 2
            let x = centerX + radius * sin(CGFloat(i) * angle)
            let y = centerY - radius * cos(CGFloat(i) * angle)
            starPath.addLine(to: CGPoint(x: x, y: y))
        }

        starPath.close()

        context.saveGState()
        context.setFillColor(fill ? UIColor.yellow.cgColor : UIColor.gray.cgColor)
        context.addPath(starPath.cgPath)
        context.fillPath()
        context.restoreGState()
    }
}
