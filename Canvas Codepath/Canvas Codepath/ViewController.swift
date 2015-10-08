//
//  ViewController.swift
//  Canvas Codepath
//
//  Created by admin on 10/7/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    var newlyCreatedFaceCenter: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    @IBAction func smileyPanGestureRecognizer(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            
            let imageView = panGestureRecognizer.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            self.newlyCreatedFaceCenter = self.newlyCreatedFace.center;
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            let translation = panGestureRecognizer.translationInView(self.view);
            
            newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceCenter.x + translation.x,
                y: self.newlyCreatedFaceCenter.y + translation.y)
            
            print("Velocity: \(panGestureRecognizer.velocityInView(self.view))")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayCenterWhenOpen = CGPoint(x: 0, y: self.view.frame.height - trayView.frame.height)
        trayCenterWhenClosed = CGPoint(x: 0, y: self.view.frame.height - 50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = panGestureRecognizer.locationInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
//            print("Gesture began at: \(point)")
            self.trayOriginalCenter = self.trayView.center;
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
//            print("Gesture changed at: \(point)")
            
            let translation = panGestureRecognizer.translationInView(self.view);
            
            trayView.center = CGPoint(x: trayOriginalCenter.x,
                y: trayOriginalCenter.y + translation.y)

//            print("Velocity: \(panGestureRecognizer.velocityInView(self.view))")

        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
//            print("Gesture ended at: \(point)")
            
            if panGestureRecognizer.velocityInView(self.view).y > 0 {
                // Moving down
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    var frame = self.trayView.frame
                    frame.origin = self.trayCenterWhenClosed
                    self.trayView.frame = frame
                })
            } else {
                // Moving up
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    var frame = self.trayView.frame
                    frame.origin = self.trayCenterWhenOpen
                    self.trayView.frame = frame
                })
            }
        }
    }
}

