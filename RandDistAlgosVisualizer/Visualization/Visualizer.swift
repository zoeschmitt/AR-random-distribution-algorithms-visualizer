//
//  Visualizer.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

/// the container that holds the objects that we’ll place in the world to visualize the point set.
class Visualizer: SCNNode {
    let controlNode = SCNNode()

    init(with points: [CGPoint]) {
        super.init()

        self.addChildNode(controlNode)
        points.forEach({ (point) in
            let sphere = self.createSphere(size: 0.03)
            sphere.position = SCNVector3(Float(point.x), 0, Float(point.y))
            controlNode.addChildNode(sphere)
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createSphere(size: Float) -> SCNNode {
        let sphere = SCNSphere(radius: CGFloat(size))
        sphere.firstMaterial?.diffuse.contents = UIColor.blue

        let node = SCNNode(geometry: sphere)
        return node
    }
}
