//
//  PointGenerator.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

protocol PointGenerator {
    /// Given a number of points to generate and a width and length to limit the points to, give back an array of points:
    mutating func generatePoints(numPoints: Int, maxWidth: Float, maxLength: Float) -> [CGPoint]
}
