//
//  Samomo.swift
//  SpriteKit Animation samomo
//
//  Created by HSIAO JENHAO on 2017-04-20.
//  Copyright © 2017 HSIAO JENHAO. All rights reserved.
//

import SpriteKit
import GameplayKit

class Samomo {

    var sprite: SKSpriteNode!
    var spriteTail: SKSpriteNode!
    var SheetsStandFront: [SKTexture] = []
    var SheetsStandBack: [SKTexture] = []
    var SheetsStandLeft: [SKTexture] = []
    var SheetsStandRight: [SKTexture] = []
    var SheetsWalkFront:[SKTexture] = []
    var SheetsWalkBack:[SKTexture] = []
    var SheetsWalkLeft:[SKTexture] = []
    var SheetsWalkRight:[SKTexture] = []
    var ActionStandFront: SKAction!
    var ActionStandBack: SKAction!
    var ActionStandLeft: SKAction!
    var ActionStandRight: SKAction!
    var ActionWalkFront:SKAction!
    var ActionWalkBack:SKAction!
    var ActionWalkLeft:SKAction!
    var ActionWalkRight:SKAction!

    var currentStatus:String
    var previousStatus:String

    var currentDirection:String
    var previousDirection:String

    var tailPostionYValue:CGFloat





    init(name: String, scale: CGFloat) {
        
     
        
        
        //MARK:Sprite
        //1
        for i in 1...4 {
            SheetsStandFront.append(SKTexture(imageNamed: "Samomo-stand-Front-\(i)"))
            SheetsStandBack.append(SKTexture(imageNamed: "Samomo-stand-Back-\(i)"))
            SheetsStandLeft.append(SKTexture(imageNamed: "Samomo-stand-left-\(i)"))
            SheetsStandRight.append(SKTexture(imageNamed: "Samomo-stand-Right-\(i)"))

        }

        for i in 1...6 {
            SheetsWalkFront.append(SKTexture(imageNamed: "Samomo-Walk-front-\(i)"))
            SheetsWalkBack.append(SKTexture(imageNamed: "Samomo-Walk-back-\(i)"))
            SheetsWalkLeft.append(SKTexture(imageNamed: "Samomo-Walk-Left-\(i)"))
            SheetsWalkRight.append(SKTexture(imageNamed: "Samomo-Walk-Right-\(i)"))

        }

        //2
        let firstFrame = SheetsStandFront[0]
        sprite = SKSpriteNode(texture: firstFrame)

        sprite.setScale(scale)

        //3
        ActionStandFront = SKAction.animate(with: SheetsStandFront, timePerFrame: 0.2)
        ActionStandBack = SKAction.animate(with: SheetsStandBack, timePerFrame: 0.2)
        ActionStandLeft = SKAction.animate(with: SheetsStandLeft, timePerFrame: 0.2)
        ActionStandRight = SKAction.animate(with: SheetsStandRight, timePerFrame: 0.2)
        ActionWalkFront = SKAction.animate(with: SheetsWalkFront, timePerFrame: 0.15)
        ActionWalkBack = SKAction.animate(with: SheetsWalkBack, timePerFrame: 0.15)
        ActionWalkLeft = SKAction.animate(with: SheetsWalkLeft, timePerFrame: 0.15)
        ActionWalkRight = SKAction.animate(with: SheetsWalkRight, timePerFrame: 0.15)

        sprite.run(SKAction.repeatForever(ActionStandFront))


        //MARK: tail
        tailPostionYValue = -1.5
        spriteTail = SKSpriteNode(texture: SKTexture(imageNamed: "Samomo-Front-tail"))
        spriteTail.setScale(1.5)
        spriteTail.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: self.sprite.size.height * tailPostionYValue)
        let tailRotateL = SKAction.rotate(byAngle: CGFloat(Double.pi) * 0.1, duration: 0.2)
        let tailRotateR = SKAction.rotate(byAngle: CGFloat(Double.pi) * -0.1, duration: 0.2)

        let tailSequence = SKAction.sequence([tailRotateL,tailRotateR])
        let tailShake = SKAction.repeatForever(tailSequence)


        spriteTail.run(tailShake)
        sprite.addChild(spriteTail)

        sprite.zPosition = 1
        spriteTail.zPosition = -1

        currentStatus = "Stand"
        previousStatus = "Stand"

        currentDirection = "Front"
        previousDirection = "Front"


    }


    func StandFront(){

        sprite.run(SKAction.repeatForever(ActionStandFront))
        spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: self.sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = -1
        spriteTail.xScale = 1.5
        sprite.zPosition = 1
    }

    func StandBack(){

        sprite.run(SKAction.repeatForever(ActionStandBack))

        spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = 1
        spriteTail.xScale = -1.5
        sprite.zPosition = spriteTail.zPosition - 2
    }

    func StandLeft(){

        sprite.run(SKAction.repeatForever(ActionStandLeft))

        spriteTail.position = CGPoint(x: sprite.size.width * 1.5 , y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition =  -1
        spriteTail.xScale = 1.5
        sprite.zPosition = spriteTail.zPosition + 2

    }

    func StandRight(){

        sprite.run(SKAction.repeatForever(ActionStandRight))

        spriteTail.position = CGPoint(x: sprite.size.width * -1.0, y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = -1
        spriteTail.xScale = -1.5
        sprite.zPosition = spriteTail.zPosition + 2
    }

    func WalkRight(){

        spriteTail.position = CGPoint(x: sprite.size.width * -1.0, y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = -1
        spriteTail.xScale = -1.5
        sprite.zPosition = spriteTail.zPosition + 2

        sprite.run(SKAction.repeatForever(ActionWalkRight)) // Start play walk right Action

    }

    func WalkLeft(){

        spriteTail.position = CGPoint(x: sprite.size.width * 1.5 , y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition =  -1
        spriteTail.xScale = 1.5
        sprite.zPosition = spriteTail.zPosition + 2

        sprite.run(SKAction.repeatForever(ActionWalkLeft)) // Start play walk left Action

    }

    func WalkUp(){

        spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = 1
        spriteTail.xScale = -1.5
        sprite.zPosition = spriteTail.zPosition - 2

        sprite.run(SKAction.repeatForever(ActionWalkBack)) // Start play walk back Action

    }

    func WalkDown(){
        spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = -1
        spriteTail.xScale = 1.5
        sprite.zPosition = spriteTail.zPosition + 2

        sprite.run(SKAction.repeatForever(ActionWalkFront)) // Start play walk front Action

    }

    func ActionStatus(VerX:CGFloat, VerY: CGFloat,angle: CGFloat) {


        // Status:


        if VerX == 0 && VerY == 0 {
            currentStatus = "Stand"


        }else{
            currentStatus = "Walk"
        // Direction:

            if angle <= 135 && angle >= 45 {
                currentDirection = "Back"
                
            }else if angle <= 45 && angle >= 00 || angle <= 360 && angle >= 315 {
                currentDirection = "Right"
                
            }else if angle <= 315 && angle >= 225 {
                currentDirection = "Front"
                
            }else if angle <= 225 && angle >= 135 {
                currentDirection = "Left"
                
            }else {
                currentDirection = "No value ****************"
            }
        }


        if currentStatus != previousStatus || currentDirection != previousDirection{

            ActionAnim(Status: currentStatus, Direction: currentDirection)
        }else {
            //do nothing
        }
        
    }
    

    
    func ActionAnim(Status: String, Direction: String) {

        previousStatus = Status

        previousDirection = Direction

        switch Status {

        case "Stand":
            switch Direction{

            case "Back":
                StandBack()
            case "Front":
                StandFront()
            case "Left":
                StandLeft()
            case "Right":
                StandRight()
            default:
                StandFront()


            }

        case "Walk":
            switch Direction{

            case "Back":
                WalkUp()
            case "Front":
                WalkDown()
            case "Right":
                WalkRight()
            case "Left":
                WalkLeft()
            default:
                WalkDown()
            }

        default:
            StandFront()
            
        }
        
    }
    
    
    
    }











