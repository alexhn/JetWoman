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
    
    private var currentCharacter: Character?
    private var label : SKLabelNode?
    private var scorelabel: SKLabelNode?
    private var jetWoman: SKSpriteNode?
    private var startButton: SKSpriteNode?
    private var score = 0
    private var gameFinished = true
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        self.scorelabel = self.childNode(withName: "//scorelabel") as? SKLabelNode
        
        if let label = self.label {
            label.alpha = 0.0
           // label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.jetWoman = self.childNode(withName: "//jetwoman") as? SKSpriteNode
        self.startButton = self.childNode(withName: "//startbutton") as? SKSpriteNode
        
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)
        let nodesAtPoint = nodes(at: point)
        for node in nodesAtPoint {
            if node.name == "startbutton" {
                startGame()
                node.removeFromParent()
            }
        }
    }
    
    func chooseNextKey() {
        let shift = arc4random_uniform(26)
        let char = Character(UnicodeScalar(("a" as UnicodeScalar).value + shift)!)
        if let label = self.label {
            label.text = String(char).uppercased()
            label.run(SKAction.fadeIn(withDuration: 2.0))
            self.currentCharacter = char
        }
    }
    
    func startGame() {
        if let jetWoman = self.jetWoman {
            jetWoman.position = CGPoint(x: 0, y: 90)
            jetWoman.physicsBody?.pinned = false
            gameFinished = false
            score = 0
            chooseNextKey()
            updateScoreLabel()
        }
    }
    override func keyDown(with event: NSEvent) {
        if let chars = event.characters {
            if let currentChar = self.currentCharacter {
                print(chars)
                print(currentChar)
                if chars.contains(currentChar) {
                    if let jetWoman = self.jetWoman {
                        jetWoman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
                        score += 1
                        updateScoreLabel()
                        chooseNextKey()
                    }
                }
            }
        }
    }
    
    func updateScoreLabel() {
        self.scorelabel?.text = "Score: \(score)"
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if bodyA.categoryBitMask == spikesCategory || bodyB.categoryBitMask == spikesCategory {
            if (!gameFinished) {
                gameFinished = true
                if let startButton = self.startButton {
                    addChild(startButton)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
