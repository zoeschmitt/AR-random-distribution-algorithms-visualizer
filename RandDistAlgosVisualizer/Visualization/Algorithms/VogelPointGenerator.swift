//
//  VogelPointGenerator.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

struct VogelPointGenerator: PointGenerator {
    let flippedSunflowerSpiral: Bool = false
    let seperatedSpiral: Bool = true

    mutating func generatePoints(numPoints: Int, maxWidth: Float, maxLength: Float) -> [CGPoint] {
        var points = [CGPoint]()
        let cc: Float = 0.0

        var it: Float = 0.1
        if seperatedSpiral { it = Float.pi * (3.0 - sqrtf(7.0)) }
        else if flippedSunflowerSpiral {  it = Float.pi * (1 - sqrtf(3.0)) }

        for p in 0..<numPoints {
            // Calculating polar coordinates theta (t) and radius (r)
            let t = it * Float(p)
            let r: Float = sqrtf(Float(p) / Float(numPoints))
            // Converting to the Cartesian coordinates x, y
            let x = r * cosf(t) + cc
            let y = r * sinf(t) + cc
            let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
            points.append(point)
        }

        return points
    }
}
