//
//  AnimatingSprite.swift
//  SpriteKit Game joystick
//
//  Created by HSIAO JENHAO on 2017-05-07.
//  Copyright © 2017 HSIAO JENHAO. All rights reserved.
//

import SpriteKit
class AnimatingSprite: SKSpriteNode{
    //創立enum
    enum SpriteDirection {
        case Forward, Back, Left, Right
    }

    //宣告動作object
    var facingForwardAnim :SKAction?
    var facingBackAnim: SKAction?
    var facingLeftAnim: SKAction?
    var facingRightAnim: SKAction?
    var facingDirection: SpriteDirection = .Forward{

        didSet{
            //判斷sprite的方向
            switch facingDirection{
            case .Forward:
                run(facingForwardAnim!)
            case.Back:
                run(facingBackAnim!)
            case.Left:
                run(facingLeftAnim!)
            case.Right:
                run(facingRightAnim!)

            }
        }
    }

    //可失敗的init

    required init?(coder aDecoder : NSCoder){
        fatalError("NSCoding not supported")
    }

    //指定構造器



     init(texture: SKTexture?) {
        super.init(texture: texture, color: UIColor.black , size: (texture?.size())!)
    }


}




















