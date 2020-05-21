//
//  GameScene.swift
//  JetWoman
//
//  Created by Aleksandr Nikiforov on 21.05.2020.
//  Copyright © 2020 Aleksandr Nikiforov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let jetWomanCategory : UInt32 = 2
    let spikesCategory : UInt32 = 3
    
    private var label : SKLabelNode?
    private var jetWoman: SKSpriteNode?
    private var startButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.jetWoman = self.childNode(withName: "//jetwoman") as? SKSpriteNode
        self.startButton = self.childNode(withName: "//startbutton") as? SKSpriteNode
        
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)
        let nodesAtPoint = nodes(at: point)
        for node in nodesAtPoint {
            if node.name == "startbutton" {
                if let jetWoman = self.jetWoman {
                    jetWoman.physicsBody?.pinned = false
                    node.removeFromParent()
                }
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            if let jetWoman = self.jetWoman {
                jetWoman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if bodyA.categoryBitMask == spikesCategory || bodyB.categoryBitMask == spikesCategory
        {
           print("Ran into spikes!")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
