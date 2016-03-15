//
//  ViewController.swift
//  iOSChartsDemo
//
//  Created by Breno Cruz on 3/15/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var xAccelLabel: UILabel!
    @IBOutlet weak var yAccelLabel: UILabel!
    @IBOutlet weak var zAccelLabel: UILabel!
    
    @IBOutlet weak var xRotLabel: UILabel!
    @IBOutlet weak var yRotLabel: UILabel!
    @IBOutlet weak var zRotLabel: UILabel!
    
    var movementManager = CMMotionManager()
    
    
    override func viewDidLoad() {
        
        movementManager.accelerometerUpdateInterval = 0.2
        movementManager.gyroUpdateInterval = 0.2
        
        movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        movementManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
            
            
        })
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func outputAccData(acceleration: CMAcceleration){
        
        let roundX = Double(round(1000*acceleration.x)/1000)
        let roundY = Double(round(1000*acceleration.y)/1000)
        let roundZ = Double(round(1000*acceleration.z)/1000)
        
        xAccelLabel?.text = "\(roundX).2fg"
        yAccelLabel?.text = "\(roundY).2fg"
        zAccelLabel?.text = "\(roundZ).2fg"

        
        
        /*if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
        currentMaxAccelX = acceleration.x
        }
        
        yAccelLabel?.text = "\(acceleration.y).2fg"
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
        currentMaxAccelY = acceleration.y
        }
        
        zAccelLabel?.text = "\(acceleration.z).2fg"
        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
        {
        currentMaxAccelZ = acceleration.z
        }
        
        
        xMaxAccelLabel?.text = "\(currentMaxAccelX).2f"
        yMaxAccelLabel?.text = "\(currentMaxAccelY).2f"
        zMaxAccelLabel?.text = "\(currentMaxAccelZ).2f"
        */
        
    }
    
    func outputRotData(rotation: CMRotationRate){
        
        let roundX = Double(round(1000*rotation.x)/1000)
        let roundY = Double(round(1000*rotation.y)/1000)
        let roundZ = Double(round(1000*rotation.z)/1000)
        
        
        xRotLabel?.text = "\(roundX).2fr/s"
        yRotLabel?.text = "\(roundY).2fr/s"
        zRotLabel?.text = "\(roundZ).2fr/s"

        
        /*
        if fabs(rotation.x) > fabs(currentMaxRotX)
        {
        currentMaxRotX = rotation.x
        }
        
        yRotLabel?.text = "\(rotation.y).2fr/s"
        if fabs(rotation.y) > fabs(currentMaxRotY)
        {
        currentMaxRotY = rotation.y
        }
        
        zRotLabel?.text = "\(rotation.z).2fr/s"
        if fabs(rotation.z) > fabs(currentMaxRotZ)
        {
        currentMaxRotZ = rotation.z
        }
        
        
        
        
        xMaxRotLabel?.text = "\(currentMaxRotX).2f"
        yMaxRotLabel?.text = "\(currentMaxRotY).2f"
        zMaxRotLabel?.text = "\(currentMaxRotZ).2f"
        
        */
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}