//
//  ViewController.swift
//  MissileLaunch
//
//  Created by Aishvi Vivek Shah on 30/8/18.
//  Copyright © 2018 Aishvi Vivek Shah. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let missileScene = SCNScene(named: "art.scnassets/missile.scn")!
        let missileNode = missileScene.rootNode.childNode(withName: "Missile", recursively: true)
        missileNode?.position = SCNVector3(0,0,-0.5)
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(missileNode!)
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
      
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
}
