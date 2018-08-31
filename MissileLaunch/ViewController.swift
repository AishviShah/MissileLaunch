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
        sceneView.autoenablesDefaultLighting = true
        //sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        let missileScene = SCNScene(named: "art.scnassets/missile.scn")!
//        let missileNode = missileScene.rootNode.childNode(withName: "Missile", recursively: true)
//        missileNode?.position = SCNVector3(0,0,-0.5)
        
        let missile = Missile(scene: missileScene)
        missile.name = "Missile"
        missile.position = SCNVector3(0,0,-4)
        
        let scene = SCNScene()
        //scene.rootNode.addChildNode(missileNode!)
        scene.rootNode.addChildNode(missile)
        sceneView.scene = scene
        
        registerTapGestureRecognizer()
    }
    
    private func registerTapGestureRecognizer()
    {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(objectTapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func objectTapped (recognizer :UITapGestureRecognizer)
    {
        guard let missileNode = self.sceneView.scene.rootNode.childNode(withName: "Missile", recursively: true)
        else
        {
            fatalError("Missile not found")
        }
        
        guard let smokeNode = self.sceneView.scene.rootNode.childNode(withName: "Smoke", recursively: true)
            else
        {
            fatalError("Missile not found")
        }
        smokeNode.removeAllParticleSystems()
        
        let fire = SCNParticleSystem(named: "fire.scnp", inDirectory: nil)
        smokeNode.addParticleSystem(fire!)
        
        missileNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        missileNode.physicsBody?.isAffectedByGravity = false
        missileNode.physicsBody?.damping = 0.0
        missileNode.physicsBody?.applyForce(SCNVector3(0,100,0), asImpulse: false)
        
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
