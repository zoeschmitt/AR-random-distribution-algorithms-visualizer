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
    let forest: Bool = true

    init(with points: [CGPoint]) {
        super.init()

        self.addChildNode(controlNode)

        if forest {
            points.forEach({ (point) in
                createForest(point: point)
            })
        } else {
            points.forEach({ (point) in
                let sphere = self.createSphere(size: 0.01)
                sphere.position = SCNVector3(Float(point.x), 0, Float(point.y))
                controlNode.addChildNode(sphere)
            })
        }
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

    func createForest(point: CGPoint) {
        let tree = Tree()

        let endScale: Float = 0.008
        tree.scale = SCNVector3(endScale, 0.0, endScale)
        let duration = 1.0;
        let startScale = tree.scale.y;

        let delay = SCNAction.wait(duration: TimeInterval(Float.random(min: 0.1, max: 0.5)))
        let scaleUp = SCNAction.customAction(duration: duration, action: { (node, elapsedTime) in
            let currentScale = CGFloat(startScale) + CGFloat(endScale) * (elapsedTime / CGFloat(duration))
            node.scale = SCNVector3Make(endScale, Float(currentScale), endScale)
        })
        let sequence = SCNAction.sequence([delay, scaleUp])
        tree.runAction(sequence)

        tree.position = SCNVector3(Float(point.x), -0.05, Float(point.y))
        controlNode.addChildNode(tree)
    }
}
