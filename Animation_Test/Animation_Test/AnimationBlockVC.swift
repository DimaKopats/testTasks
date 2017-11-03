//
//  AnimationBlockVC.swift
//  Animation_Test
//
//  Created by Dmitry on 31.10.17.
//  Copyright © 2017 Dzmitry Kopats. All rights reserved.
//

import UIKit

class AnimationBlockVC: UIViewController {
    
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView! // для анимации через блоки
    
    let cornerRadius: CGFloat = 25
    var randomColor: UIColor = UIColor(red: 196/255, green: 249/255, blue: 78/255, alpha: 1)
    let layer1 = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transformToCircle(view: circle1)
        transformToCircle(view: circle2)
        transformToCircle(view: circle3)
        circle3.isHidden = true
        circle2.backgroundColor = randomColor
        self.view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        
        //creating ball
        let ball = UIImageView.init(image: #imageLiteral(resourceName: "smallBall"))
        ball.frame.size = circle1.frame.size
        circle1.addSubview(ball)
        circle1.clipsToBounds = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(ViewController.sampleTapGestureTapped(recognizer:)))
        self.view.addGestureRecognizer(tapGR)
    }
    
    func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        var tapPoint = recognizer.location(in: self.view)
        let animationDuration: CFTimeInterval = 5 // animation diration in seconds
        let indentFromBoard = 1 + cornerRadius
        tapPoint = self.check(tapPoint: tapPoint, indentFromBoard: indentFromBoard)
        
//        print("tapPoint == \(tapPoint)")
//        print("circle1.layer.presentation()?.frame.origin == \(self.circle1.layer.presentation()!.frame.origin)")
//        print("circle2.layer.presentation()?.frame.origin == \(self.circle2.layer.presentation()!.frame.origin)")

        
        
        
        
        
        
        if self.view.hitTest(tapPoint, with: nil) == self.circle2 {
//            print("tap inside circle2-------------------------")
        } else {
            self.circle2.layer.removeAllAnimations()
            self.circle1.layer.removeAllAnimations()
            
//            self.circle2.frame.origin = (self.circle2.layer.presentation()?.frame.origin)!
//            if let presentationColor = self.circle2.layer.presentation()?.backgroundColor {
                //                self.circle2.backgroundColor = UIColor(cgColor: presentationColor)
//            }
            
            self.circle1.frame.origin.x = (self.circle1.layer.presentation()?.frame.origin.x)!
            self.circle2.frame.origin.x = (self.circle2.layer.presentation()?.frame.origin.x)!
            //            self.circle2.layer.removeAllAnimations()
            //            print("animations = \(self.circle2.layer.animationKeys())")
        }
        
        
        
        
        
        
        
        
        // moving green circle
        moveWithHorizontalZigZag(circle: self.circle2,
                                 finishPoint: tapPoint,
                                 animationDuration: animationDuration,
                                 indent: indentFromBoard)
        // moving ball circle
//        moveInLine(circle: circle1,
//                   finishPoint: tapPoint,
//                   animationDuration: animationDuration)
    }
    
    func check(tapPoint: CGPoint, indentFromBoard: CGFloat) -> CGPoint {
        var resultPoint = tapPoint
        let screenBounds = UIScreen.main.bounds
        
        if resultPoint.x <= indentFromBoard {
            resultPoint.x = indentFromBoard
        } else if resultPoint.x >= (screenBounds.width - indentFromBoard) {
            resultPoint.x = screenBounds.width - indentFromBoard
        }
        
        if resultPoint.y <= indentFromBoard {
            resultPoint.y = indentFromBoard
        } else if resultPoint.y >= (screenBounds.height - indentFromBoard) {
            resultPoint.y = screenBounds.height - indentFromBoard
        }
        
        return resultPoint
    }
    
    // moving view + horizontal ZigZag
    func moveWithHorizontalZigZag(circle: UIView, finishPoint: CGPoint, animationDuration: CFTimeInterval, indent: CGFloat) {
        var startPoint = circle.frame.origin
        startPoint.x += self.cornerRadius
        startPoint.y += self.cornerRadius
        let screenBounds = UIScreen.main.bounds
        circle.backgroundColor = randomColor
        randomColor = self.createRandomColor()
        
        // animation along vertical axis
//        UIView.animate(withDuration: animationDuration, animations: {
//            print("circle.layer.position.y = \(circle.layer.position.y)")
//            print("finishPoint.y = \(finishPoint.y)")
//            
//            
//        }) { finished in
//            print("animationX for circle2 completed")
//        }
        
        //animation along horizontal axis
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: animationDuration, animations: {
                
                circle.layer.position.y = finishPoint.y
                circle.layer.backgroundColor = self.randomColor.cgColor
            })
            
            var resultXPath: CGFloat
            var part1XPath: CGFloat
            let part2XPath = screenBounds.width - 2*indent
            
            var firstPoint: CGFloat
            var secondPoint: CGFloat
            
            if startPoint.x < screenBounds.width/2 {
                firstPoint = indent
                secondPoint = screenBounds.width - indent
                part1XPath = startPoint.x - indent
                resultXPath = 2*screenBounds.width + startPoint.x - finishPoint.x - 4*indent
                
            } else {
                firstPoint = screenBounds.width - indent
                secondPoint = indent
                part1XPath = screenBounds.width - startPoint.x - indent
                resultXPath = 2*screenBounds.width - startPoint.x + finishPoint.x - 4*indent
            }
            
            var startTime: Double = 0
            var durationTime: CGFloat = part1XPath/resultXPath
            
            UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: Double(durationTime), animations: {
                circle.layer.position.x = firstPoint
            })
            
            startTime += Double(durationTime)
            durationTime = part2XPath/resultXPath
            UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: Double(durationTime), animations: {
                circle.layer.position.x = secondPoint
            })
            
            startTime += Double(durationTime)
            durationTime = (resultXPath - part1XPath - part2XPath)/resultXPath
            UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: Double(durationTime), animations: {
                circle.layer.position.x = finishPoint.x
            })
        }) { finished in
            print("animationY for circle2 completed")
        }
        

        
        
        
        
        
        
//        // change circle size animation
//        let zoomInAnimation = CABasicAnimation()
////        zoomInAnimation.keyPath = "transform.scale"
////        zoomInAnimation.toValue = 0.5
////        zoomInAnimation.duration = 0.25*animationDuration
////        zoomInAnimation.isRemovedOnCompletion = false
////        zoomInAnimation.fillMode = kCAFillModeForwards
//        
//        let zoomOutAnimation = CABasicAnimation()
////        zoomOutAnimation.keyPath = "transform.scale"
////        zoomOutAnimation.toValue = 1
////        zoomOutAnimation.duration = 0.25*animationDuration
////        zoomOutAnimation.beginTime = 0.75*animationDuration
////        zoomOutAnimation.isRemovedOnCompletion = false
////        zoomOutAnimation.fillMode = kCAFillModeForwards
//        

    }
    
    // moving view linear
    func moveInLine(circle: UIView, finishPoint: CGPoint, animationDuration: CFTimeInterval) {
        
        UIView.animate(withDuration: animationDuration, animations: {
            circle.layer.position = finishPoint
            UIView.animate(withDuration: animationDuration/2, animations: {
                circle.transform = CGAffineTransform(rotationAngle: .pi)
            }, completion: { finished in
                print("first part rotate complete")
                
            })
            UIView.animate(withDuration: animationDuration/2, delay: animationDuration/2, options: [], animations: {
                circle.transform = .identity
            }, completion: { finished in
                print("second part rotate complete")
                
            })
//            circle.transform = circle.transform.rotated(by: .pi)
        }) { finished in
            print("animation for ball completed")
        }
    }
    
    func transformToCircle(view: UIView) {
        view.layer.borderWidth = 3
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = UIColor.gray.cgColor
    }
    
    func createRandomColor() -> (UIColor) {
        let rand1:CGFloat = ((CGFloat)(arc4random() % 256))/255
        let rand2:CGFloat = ((CGFloat)(arc4random() % 256))/255
        let rand3:CGFloat = ((CGFloat)(arc4random() % 256))/255
        
        let color = UIColor.init(red: rand1,
                                 green: rand2,
                                 blue: rand3,
                                 alpha: 1)
        return color
    }
}


