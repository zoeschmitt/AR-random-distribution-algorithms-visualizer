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

    func createPointField(position: SCNVector3) {
//        var randomGenerator = RandomPointGenerator()
//        let points = randomGenerator.generatePoints(numPoints: 130, maxWidth: 4.0, maxLength: 4.0)

        var mitchellGenerator = MitchellPointGenerator()
        let points = mitchellGenerator.generatePoints(numPoints: 130, maxWidth: 0.4, maxLength: 0.4)
        
        let visualizer = Visualizer(with: points)
        scene?.rootNode.addChildNode(visualizer)
        visualizer.position = position
    }
}
