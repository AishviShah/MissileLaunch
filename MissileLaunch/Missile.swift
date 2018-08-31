//
//  Missile.swift
//  MissileLaunch
//
//  Created by Aishvi Vivek Shah on 31/8/18.
//  Copyright © 2018 Aishvi Vivek Shah. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class Missile : SCNNode
{
    private var scene :SCNScene!
    
    init(scene: SCNScene)
    {
        super.init()
        self.scene = scene
        setup()
    }
    
    init(missileNode : SCNNode)
    {
        super.init()
        setup()
    }
    private func setup()
    {
        guard let missileNode = self.scene.rootNode.childNode(withName: "Missile", recursively: true),
              let smokeNode = self.scene.rootNode.childNode(withName: "Smoke", recursively: true)
        else
        {
            fatalError("Node not found")
        }
        let smoke = SCNParticleSystem(named: "smoke.scnp", inDirectory: nil)
        smokeNode.addParticleSystem(smoke!)
        
        self.addChildNode(missileNode)
        self.addChildNode(smokeNode)
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
