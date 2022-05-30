//
//  MainScene.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation
import SceneKit

struct MainScene {

    var scene: SCNScene?

    init() {
        scene = self.initializeScene()
    }

    func initializeScene() -> SCNScene? {
        let scene = SCNScene()

        setDefaults(scene: scene)

        return scene
    }

    func setDefaults(scene: SCNScene) {

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = SCNLight.LightType.ambient
        ambientLightNode.light?.color = UIColor(white: 0.8, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)

        // Create a directional light with an angle to provide a more interesting look
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor(white: 0.8, alpha: 1.0)
        let directionalNode = SCNNode()
        directionalNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-40), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        directionalNode.light = directionalLight
        scene.rootNode.addChildNode(directionalNode)
    }

    func createPointField(position: SCNVector3, algorithm: AlgorithmOptions, trees: Bool) {
        var generator: PointGenerator = RandomPointGenerator()

        switch algorithm {
        case .simple:
            break
        case .mitchell:
            generator = MitchellPointGenerator()
        case .sunflower:
            generator = SunflowerPointGenerator()
        case .vogel:
            generator = VogelPointGenerator()
        }

        let points = generator.generatePoints(numPoints: 130, maxWidth: 4.0, maxLength: 4.0)
        let visualizer = Visualizer(with: points, trees: trees)
        visualizer.name = "visualizer"
        scene?.rootNode.addChildNode(visualizer)
        visualizer.position = position
    }

    func resetPointField() {
        scene?.rootNode.childNodes.filter({ $0.name == "visualizer" }).forEach({ $0.removeFromParentNode() })
    }
}
