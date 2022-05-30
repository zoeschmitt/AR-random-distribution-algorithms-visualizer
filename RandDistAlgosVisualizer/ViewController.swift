//
//  ViewController.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import UIKit
import SceneKit
import ARKit

enum AlgorithmOptions: String {
    case simple = "Simple"
    case mitchell = "Mithcell's Best-Candidate"
    case sunflower = "Sunflower Seed Spiral"
    case vogel = "Vogels Spiral"
}

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var algorithmsButton: UIButton!
    @IBOutlet var sphereOrTreeControl: UISegmentedControl!

    var sceneController = MainScene()
    var didInitializeScene: Bool = false
    let algorithmOptions: [AlgorithmOptions] = [AlgorithmOptions.simple, AlgorithmOptions.mitchell, AlgorithmOptions.sunflower, AlgorithmOptions.vogel]
    var selectedAlgorithm: AlgorithmOptions = AlgorithmOptions.simple
    var trees: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Create a new scene
        if let scene = sceneController.scene {
            // Set the scene to the view
            sceneView.scene = scene
        }

        algorithmsButton.menu = UIMenu(children: menuItems)
        algorithmsButton.showsMenuAsPrimaryAction = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapScreen))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    @objc func didTapScreen(recognizer: UITapGestureRecognizer) {
        if didInitializeScene {
            if let camera = sceneView.session.currentFrame?.camera {
                var translation = matrix_identity_float4x4
                translation.columns.3.z = -1.0
                let transform = camera.transform * translation
                let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
                sceneController.createPointField(position: position, algorithm: selectedAlgorithm, trees: trees)
            }
        }
    }
    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if !didInitializeScene {
            if sceneView.session.currentFrame?.camera != nil {
                didInitializeScene = true
            }
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }

    // MARK: - IBActions
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            trees = false
        case 1:
            trees = true
        default:
            break;
        }
        sceneController.resetPointField()
    }
}

extension ViewController {
    var menuItems: [UIAction] {
        var items: [UIAction] = []
        for algo in algorithmOptions {
            items.append(UIAction(title: algo.rawValue, handler: { (_) in
                self.selectedAlgorithm = algo
                self.sceneController.resetPointField()
            }))
        }
        return items
    }
}
