//
//  SensorCollection.swift
//  FitnessAppWatch Extension
//
//  Created by Larry Tseng on 10/19/19.
//  Copyright © 2019 FitnessApp. All rights reserved.
//

import Foundation
import CoreMotion

class SensorCollection {
    
    let manager: CMMotionManager = CMMotionManager()
    let accelQueue: OperationQueue = OperationQueue()

    init() {
        print("Running")
        accelQueue.name = "Accelerometer Queue"
        manager.accelerometerUpdateInterval = 0.25;
        manager.startAccelerometerUpdates(to: accelQueue, withHandler: handleAccelData)
        manager.deviceMotionUpdateInterval = 0.25;
        manager.startDeviceMotionUpdates()
    }
    
    func handleAccelData(data: CMAccelerometerData?, error: Error?) {
        guard let data = data else {
            return;
        }
        
        guard let deviceMotion = manager.deviceMotion else {
            return;
        }
        
        let x = String(format: "%.2f", data.acceleration.x - deviceMotion.gravity.x)
        let y = String(format: "%.2f", data.acceleration.y - deviceMotion.gravity.y)
        let z = String(format: "%.2f", data.acceleration.z - deviceMotion.gravity.z)
        
        print("x: \(x), y: \(y), z: \(z), gravityX: \(deviceMotion.gravity.x)")
        
        if (-1.05 ..< -0.95).contains(deviceMotion.gravity.x)  {
            print("END")
        }
    }
}