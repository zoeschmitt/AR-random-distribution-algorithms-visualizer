//
//  Tree.swift
//  RandDistAlgosVisualizer
//
//  Created by Zoe Schmitt on 5/29/22.
//

import Foundation


class Tree: SceneObject {

    let treeName = "Tree.dae"
    init() {
        super.init(from: treeName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
