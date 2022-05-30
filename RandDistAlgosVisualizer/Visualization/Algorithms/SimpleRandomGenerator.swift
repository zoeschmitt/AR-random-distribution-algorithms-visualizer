//
//  SimpleRandomGenerator.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

/// We iterate and create points that lie within the width and length limits, placing points on either side of the midpoint of those limits.
struct RandomPointGenerator: PointGenerator {
    mutating func generatePoints(numPoints: Int, maxWidth: Float, maxLength: Float) -> [CGPoint] {
        var points = [CGPoint]()

        for _ in 0..<numPoints {
            let x = Float.random(min: -maxWidth / 2, max: maxWidth / 2)
            let y = Float.random(min: -maxLength / 2, max: maxLength / 2)

            let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
            points.append(point)
        }

        return points
    }
}
