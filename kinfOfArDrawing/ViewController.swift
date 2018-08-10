//
//  ViewController.swift
//  kinfOfArDrawing
//
//  Created by Jakub Slawecki on 10.08.2018.
//  Copyright © 2018 Jakub Slawecki. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
       
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering...")
    }


}

