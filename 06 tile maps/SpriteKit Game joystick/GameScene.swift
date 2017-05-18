//
//  GameScene.swift
//  SpriteKit Game joystick
//
//  Created by HSIAO JENHAO on 2017-04-25.
//  Copyright © 2017 HSIAO JENHAO. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, JDPaddleVectorDelegate {

    var paddle:JDPaddle!  //Joystick
    var JoyStickPostion = CGPoint()

    var xLabel :SKLabelNode!
    var yLabel :SKLabelNode!
    var labelLoction : SKLabelNode!

    let player = Samomo(name: "SamomoPlayer", scale: 0.15)
    var touchLocation = CGPoint()
    var directionX : CGFloat = 0
    var directionY : CGFloat = 0

    var tree: SKSpriteNode!
    var oops: SKSpriteNode! // just temporary
    
    var XYAxisBackGroud: SKSpriteNode!

    var cameraNode = SKCameraNode()

    override func didMove(to view: SKView) {
        
        
        print("frame size:",(frame.size))

       

        backgroundColor = SKColor.gray

        xLabel = SKLabelNode(text: "0.0")
        xLabel.position = CGPoint(x: 0.0,y: self.frame.minY - 230)
        xLabel.zPosition = 0
        
        yLabel = SKLabelNode(text: "0.0")
        yLabel.position = CGPoint(x: 0.0,y: self.frame.minY - 200)
        yLabel.zPosition = 0
        labelLoction = SKLabelNode(text: "0.0")
        labelLoction.position = CGPoint(x: 0.0,y: self.frame.minY - 260)
        labelLoction.fontSize = 20
        labelLoction.zPosition = 0

        cameraNode.addChild(xLabel)
        cameraNode.addChild(yLabel)
        cameraNode.addChild(labelLoction)


        // camera Node
        addChild(cameraNode)
        cameraNode.position.x = size.width / 2
        cameraNode.position.y = size.height / 2

        camera = cameraNode


        //JoyStick

        JoyStickPostion = CGPoint(x: self.frame.size.width * -0.35 , y: self.frame.size.height * -0.4)


        paddle = JDPaddle(size:  CGSize(width:100, height:100))
        paddle.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        paddle.position = JoyStickPostion
        

        cameraNode.addChild(paddle)
    

        paddle.delegate = self

        //player

        player.sprite.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        player.sprite.zPosition = 2
        addChild(player.sprite)

        touchLocation = CGPoint(x: frame.midX, y:frame.midY)

        // tree

        tree = SKSpriteNode(imageNamed: "tree")
        tree.setScale(0.3)
        tree.position = CGPoint(x: frame.width * 0.3, y: frame.height * 0.3)
//        tree.zPosition = 0 

        //oops (temporary)

        oops = SKSpriteNode(imageNamed: "oops")
        oops.setScale(0.8)
        oops.anchorPoint = CGPoint(x: 0.5, y: 0.0)

        oops.position = CGPoint(x:player.sprite.size.width * 0.5 , y:player.sprite.size.height * 2)
        oops.zPosition = 2
        
        // backgruod 
        XYAxisBackGroud = SKSpriteNode(imageNamed: "xy axis")
        XYAxisBackGroud.position = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        XYAxisBackGroud.alpha = 0.3
        XYAxisBackGroud.zPosition = -3
        addChild(XYAxisBackGroud)



        
        




    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tree.removeFromParent()
    }

    func getVector(vector:CGVector)
    {
        xLabel.text = "x:\(vector.dx)"
        yLabel.text = "y:\(vector.dy)"

        directionX = vector.dx
        directionY = vector.dy


    }

    func addoops() {
          player.sprite.addChild(oops)

    }

    func PlayerLocation() {

        let Error = "nan"

        if String(describing: directionX) == Error   {
            print("***********nan")

        }else{

            player.sprite.position.x += directionX * 3
            player.sprite.position.y += directionY * 3
//            player.CheckMovingOrNotSetp1(x: directionX, y: directionY)

            let angleDistance = atan2(directionY, directionX) - atan2(0.0, 0.0)
            var angleValue = angleDistance * CGFloat(180.0 / Double.pi)
            if angleValue < 0 { angleValue += 360 }
            

            player.ActionStatus(VerX: directionX, VerY: directionY, angle: angleValue)


//        if  player.sprite.position.y  <= self.frame.minY + 200 {
//            player.sprite.position.y = self.frame.minY + 200
//        }else if  player.sprite.position.y  >= self.frame.maxY - player.sprite.size.height / 2{
//            player.sprite.position.y = self.frame.maxY - player.sprite.size.height / 2
//        }else if player.sprite.position.x <= self.frame.minX + player.sprite.size.width / 2 {
//                player.sprite.position.x = self.frame.minX + player.sprite.size.width / 2
//            }else if  player.sprite.position.x  >= self.frame.maxX - player.sprite.size.width / 2{
//                player.sprite.position.x = self.frame.maxX - player.sprite.size.width / 2
//                       }

        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        labelLoction.text = String(describing: player.sprite.position)
        PlayerLocation()

        camera?.position = player.sprite.position
        
        print("Player:",(player.sprite.position))
        print("JoyStick:",(paddle.position))
        print("LableX:",(xLabel.position))

       
        
    }
}









