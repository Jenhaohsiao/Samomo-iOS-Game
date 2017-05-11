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
    var spriteSheetsFront: [SKTexture] = []
    var SpriteSheetsWalkFront:[SKTexture] = []
    var SpriteSheetsWalkBack:[SKTexture] = []
    var SpriteSheetsWalkLeft:[SKTexture] = []
    var SpriteSheetsWalkRight:[SKTexture] = []
    var StandFrontAction: SKAction!
    var WalkFrontAction:SKAction!
    var WalkBackAction:SKAction!
    var WalkLeftAction:SKAction!
    var WalkRightAction:SKAction!

    var walking:Bool
    var playingAnimBoolStandFront:Bool
    var playingAnimBoolWalkFront:Bool
    var playingAnimBoolWalkBack:Bool
    var playingAnimBoolWalkLeft:Bool
    var playingAnimBoolWalkRight:Bool

    var tailPostionYValue:CGFloat





    init(name: String, scale: CGFloat) {
        //MARK:Sprite
        //1
        for i in 1...4 {
            spriteSheetsFront.append(SKTexture(imageNamed: "Samomo-Front-\(i)"))
        }

        for i in 1...6 {
            SpriteSheetsWalkFront.append(SKTexture(imageNamed: "Samomo-Walk-front-\(i)"))
            SpriteSheetsWalkBack.append(SKTexture(imageNamed: "Samomo-Walk-back-\(i)"))
            SpriteSheetsWalkLeft.append(SKTexture(imageNamed: "Samomo-Left-walk-\(i)"))
            SpriteSheetsWalkRight.append(SKTexture(imageNamed: "Samomo-Right-walk-\(i)"))

        }

        //2
        let firstFrame = spriteSheetsFront[0]
        sprite = SKSpriteNode(texture: firstFrame)

        sprite.setScale(scale)

        //3
        StandFrontAction = SKAction.animate(with: spriteSheetsFront, timePerFrame: 0.2)
        WalkFrontAction = SKAction.animate(with: SpriteSheetsWalkFront, timePerFrame: 0.2)
        WalkBackAction = SKAction.animate(with: SpriteSheetsWalkBack, timePerFrame: 0.2)
        WalkLeftAction = SKAction.animate(with: SpriteSheetsWalkLeft, timePerFrame: 0.2)
        WalkRightAction = SKAction.animate(with: SpriteSheetsWalkRight, timePerFrame: 0.2)



        sprite.run(SKAction.repeatForever(StandFrontAction))



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


        walking = false
        playingAnimBoolStandFront = true
        playingAnimBoolWalkFront = false
        playingAnimBoolWalkBack = false
        playingAnimBoolWalkLeft = false
        playingAnimBoolWalkRight = false


    }

    func PlayerStandAnim(){

        playingAnimBoolStandFront = true
        playingAnimBoolWalkFront = false
        playingAnimBoolWalkBack = false
        playingAnimBoolWalkLeft = false
        playingAnimBoolWalkRight = false


        sprite.run(SKAction.repeatForever(StandFrontAction))
        spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: self.sprite.size.height * tailPostionYValue)
        spriteTail.zPosition = -1
        spriteTail.xScale = 1.5
        sprite.zPosition = 1

        print ("PlayerStandAnim")
        
        
    }

    func CheckMovingOrNotSetp1(x:CGFloat, y:CGFloat){


        if x == 0 && y == 0 {

            walking = false

            if  playingAnimBoolStandFront == false{

                PlayerStandAnim()

            }else if playingAnimBoolStandFront == true {

            playingAnimBoolStandFront = true
            playingAnimBoolWalkFront = false
            playingAnimBoolWalkBack = false
            playingAnimBoolWalkLeft = false
            playingAnimBoolWalkRight = false
            }


        }else{
            walking = true

         }


        CheckMovingOrNotSetp2(x:x, y:y)


    }




    func CheckMovingOrNotSetp2(x:CGFloat, y:CGFloat){

        if walking == false && playingAnimBoolStandFront == true {


        }else if walking == true{

            if playingAnimBoolStandFront == true {

                //            sprite.run(SKAction.repeatForever(WalkFrontAction))

                playingAnimBoolStandFront = false //trun off StandFront Bool
                playingAnimBoolWalkFront = false
                playingAnimBoolWalkBack = false
                playingAnimBoolWalkLeft = false
                playingAnimBoolWalkRight = false


                spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: sprite.size.height * tailPostionYValue)
                spriteTail.zPosition = -1
                spriteTail.xScale = 1.5
                sprite.zPosition = 1



                MoingAnimChange(x: x, y: y)

                print("Stand to moving")
            }else if playingAnimBoolStandFront != true {
                MoingAnimChange(x: x, y: y)
                print("keep moving")


            }

        }




    }

    func xyBackToZero(x:CGFloat, y:CGFloat){



        if x == 0 && y == 0 {

            playingAnimBoolStandFront = true
            playingAnimBoolWalkFront = false
            playingAnimBoolWalkBack = false
            playingAnimBoolWalkLeft = false
            playingAnimBoolWalkRight = false
            print("xyBackToZero, x = 0, y =0 ")


        }else {

            print("xyBackToZero, x != 0, y !=0 ")

            CheckMovingOrNotSetp2(x: x, y: y)

        }
    }

    func MoingAnimChange(x:CGFloat, y:CGFloat){

        //********************* Go Front (down)

        if x > -0.80 && x <= 0.80 && y < -0.60 && playingAnimBoolWalkFront == false{

            sprite.removeAllActions()

            playingAnimBoolStandFront = false
            playingAnimBoolWalkFront = true // trun on Walk Front Bool
            playingAnimBoolWalkBack = false
            playingAnimBoolWalkLeft = false
            playingAnimBoolWalkRight = false



            spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: sprite.size.height * tailPostionYValue)
            spriteTail.zPosition = -1
            spriteTail.xScale = 1.5
            sprite.zPosition = 1

            sprite.run(SKAction.repeatForever(WalkFrontAction)) // Start play walk front Action

            print ("Walk Front1","X=",(x),",Y=",(y))

            xyBackToZero(x:x, y:y)


        }else if x > -0.80 && x <= 0.80 && y < -0.60  && y >= 0 && playingAnimBoolWalkFront == true{
            print ("Walk Front2","X=",(x),",Y=",(y))



            // keep the Walk front animation going

        }
            //********************* Go Back (up)
        else if x > -0.80 && x <= 0.80 && y >= 0.60 && playingAnimBoolWalkBack == false {

            sprite.removeAllActions()

            playingAnimBoolStandFront = false
            playingAnimBoolWalkFront = false
            playingAnimBoolWalkBack = true // trun on Walk back Bool
            playingAnimBoolWalkLeft = false
            playingAnimBoolWalkRight = false



            spriteTail.position = CGPoint(x: sprite.size.width * 0.5, y: sprite.size.height * tailPostionYValue)
            spriteTail.zPosition = 1
            spriteTail.xScale = -1.5
            sprite.zPosition = -1

            sprite.run(SKAction.repeatForever(WalkBackAction)) // Start play walk back Action

            print ("Walk Back1","X=",(x),",Y=",(y))


            xyBackToZero(x:x, y:y)


        }else if x > -0.80 && x <= 0.80 && y >= 0.60 && playingAnimBoolWalkBack == true {

            // keep the Walk Left animation going
            print ("Walk Back2","X=",(x),",Y=",(y))




        }
            //********************* Go Left

        else if x <= -0.81 && y <= 0.60 && y > -0.60 && playingAnimBoolWalkLeft == false {

            sprite.removeAllActions()

            playingAnimBoolStandFront = false
            playingAnimBoolWalkFront = false
            playingAnimBoolWalkBack = false
            playingAnimBoolWalkLeft = true  // trun on Walk left Bool
            playingAnimBoolWalkRight = false



            spriteTail.position = CGPoint(x: sprite.size.width * 1.5 , y: sprite.size.height * tailPostionYValue)
            spriteTail.zPosition = -1
            spriteTail.xScale = 1.5
            sprite.zPosition = 1
            
            sprite.run(SKAction.repeatForever(WalkLeftAction)) // Start play walk left Action
            
            print ("Walk Left1","X=",(x),",Y=",(y))
            xyBackToZero(x:x, y:y)
            
            
        }else if x <= -0.81 && y <= 0.60 && y > -0.60 && playingAnimBoolWalkLeft == true {
            
            // keep the Walk left animation going
            
            print ("Walk Left2","X=",(x),",Y=",(y))
            
        }
            
            //********************* Go Right
            
        else if x > 0.81 && y < 0.60 && y >= -0.60 && playingAnimBoolWalkRight == false {
            
            sprite.removeAllActions()
            
            playingAnimBoolStandFront = false
            playingAnimBoolWalkFront = false
            playingAnimBoolWalkBack = false
            playingAnimBoolWalkLeft = false
            playingAnimBoolWalkRight = true // trun on Walk right Bool
            
            
            
            spriteTail.position = CGPoint(x: sprite.size.width * -1.0, y: sprite.size.height * tailPostionYValue)
            spriteTail.zPosition = -1
            spriteTail.xScale = -1.5
            sprite.zPosition = 1
            
            sprite.run(SKAction.repeatForever(WalkRightAction)) // Start play walk right Action
            
            print ("Walk Right1","X=",(x),",Y=",(y))
            xyBackToZero(x:x, y:y)
            
            
        }else if x > 0.81 && y < 0.60 && y >= -0.60 && playingAnimBoolWalkRight == true {
            
            // keep the Walk right animation going
            
            print ("Walk Right2","X=",(x),",Y=",(y))
            
        }
        
        
    }
    
}











