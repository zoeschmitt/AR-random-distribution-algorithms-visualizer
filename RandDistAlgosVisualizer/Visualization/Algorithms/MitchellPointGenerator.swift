//
//  MitchellPointGenerator.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

/// Mitchell's best-candidate algorithm (implementatino of Poisson-disc sampling)
///
/// For each new sample, the best-candidate algorithm generates a fixed number of candidates.
/// Each candidate is chosen uniformly from the sampling area.
/// The best candidate is the one that is farthest away from all previous samples.
/// After all candidates are created and distances measured, the best candidate becomes the new sample,
/// and the remaining candidates are discarded.
///
/// https://bost.ocks.org/mike/algorithms/#sampling
struct MitchellPointGenerator: PointGenerator {
    var radius: Float = 0.3
    let pos: SCNVector3 = SCNVector3Zero
    var points = [CGPoint]()
    var width: Float = 4
    var height: Float = 4

    mutating func generatePoints(numPoints: Int, maxWidth: Float, maxLength: Float) -> [CGPoint] {
        self.width = maxWidth
        self.height = maxLength

        for _ in 0..<numPoints {
            let pointSample = sample(anchorPos: CGPoint(x: CGFloat(pos.x), y: CGFloat(pos.z)))
            points.append(pointSample)
        }

        return points
    }

    func sample(anchorPos: CGPoint) -> CGPoint {
        var bestCandidate: CGPoint = CGPoint(x: 0, y: 0)
        var bestDistance: Float = 0
        let numCandidates = 20
        let anchorX = Float(anchorPos.x)
        let anchorZ = Float(anchorPos.y)
        for _ in 0..<numCandidates {
            let xVal = CGFloat(Float.random(min: anchorX - radius, max: anchorX + radius))
            let zVal = CGFloat(Float.random(min: anchorZ - radius, max: anchorZ + radius))
            let c = CGPoint(x: xVal, y: zVal)
            let d = distance(a: findClosest(pool: points, point: c), b: c)
            if d > bestDistance {
                bestDistance = d
                bestCandidate = c
            }
        }
        return bestCandidate
    }

    func findClosest(pool: [CGPoint], point: CGPoint) -> CGPoint {
        var currentClosest = point
        var minDistance = Float.infinity
        for aPointInPool in pool {
            let dist = distance(a: aPointInPool, b: point)
            if dist < minDistance {
                currentClosest = aPointInPool
                minDistance = dist
            }
        }
        return currentClosest
    }

    func distance(a: CGPoint, b: CGPoint) -> Float {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return Float((dx * dx + dy * dy).squareRoot())
    }
}
