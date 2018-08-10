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
    
    @IBOutlet weak var drawButton: UIButton!
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
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orintation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let possitionOfTheCamera = orintation + location
        DispatchQueue.main.async {
            if self.drawButton.isHighlighted {
                let drawingNode = SCNNode()
                drawingNode.geometry = SCNSphere(radius: 0.02)
                drawingNode.geometry?.firstMaterial?.specular.contents = UIColor.white
                drawingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
                drawingNode.position = possitionOfTheCamera
                
                self.sceneView.scene.rootNode.addChildNode(drawingNode)
            } else {
                let pointer = SCNNode()
                pointer.geometry = SCNSphere(radius: 0.01)
                pointer.name = "pointer"
                pointer.geometry?.firstMaterial?.specular.contents = UIColor.white
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.darkGray
                pointer.position = possitionOfTheCamera
                
                self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                    if node.name == "pointer" {
                         node.removeFromParentNode()
                    }
                }
                
                self.sceneView.scene.rootNode.addChildNode(pointer)
            }
        }
    }


}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}






















