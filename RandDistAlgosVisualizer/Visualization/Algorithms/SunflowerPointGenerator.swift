//
//  SunflowerPointGenerator.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

struct SunflowerPointGenerator: PointGenerator {
    /// changing the theta to a bearing to create geodesic formation
    let geoDesicFormation: Bool = false

    mutating func generatePoints(numPoints: Int, maxWidth: Float, maxLength: Float) -> [CGPoint] {
        let points = sunflower(numPoints: numPoints, alpha: 2.0, geodesic: geoDesicFormation)
        return points
    }

    public func sunflower(numPoints: Int, alpha: Float, geodesic: Bool) -> [CGPoint] {
        var points = [CGPoint]()
        let b = roundf(alpha * sqrtf(Float(numPoints)))
        let phi = 1.618
        for k in 1..<numPoints {
            let rad = radius(k: Float(k), n: Float(numPoints), b: b)
            let theta = geodesic ? Float(k) * Float(360) * Float(phi) : 2 * Float.pi * Float(k) / powf(Float(phi), 2.0)
            let thePoint = CGPoint(x: CGFloat(rad * cosf(theta)), y: CGFloat(rad * sinf(theta)))
            points.append(thePoint)
        }
        return points
    }

    public func radius(k: Float, n: Float, b: Float) -> Float {
        var r: Float = 0.0
        if k > n - b { r = 1.0 }
        else { r = sqrtf(k - 1 / 2) / sqrtf(n - (b + 1) / 2)}
        return r
    }
}
