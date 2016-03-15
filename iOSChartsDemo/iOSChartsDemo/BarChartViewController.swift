//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts
import CoreMotion
import CoreLocation


class BarChartViewController: UIViewController {

    var graphData = [0.0,0.0,0.0,0.0,0.0,0.0]
    var graphLabels: [String]!
    
    @IBOutlet var barChartView: BarChartView!
    
    var movementManager = CMMotionManager()

    override func viewDidLoad() {
        
        movementManager.accelerometerUpdateInterval = 0.75
        movementManager.gyroUpdateInterval = 0.75
        
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
        
        barChartView.noDataText = "You need to provide data for the chart."
        // Do any additional setup after loading the view, typically from a nib.
        
        graphLabels = ["X Accel", "Y Accel", "Z Accel", "X rot", "Y rot", "Z rot"]
    }

    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "g")
        let chartData = BarChartData(xVals: graphLabels, dataSet: chartDataSet)
        barChartView.data = chartData
        ChartColorTemplates.vordiplom()

        let ll = ChartLimitLine(limit: 0.0, label: "Zero")
        barChartView.rightAxis.addLimitLine(ll)
        
    }
    
    
    func outputAccData(acceleration: CMAcceleration){

        graphData[0] = acceleration.x * 100
        graphData[1] = acceleration.y * 100
        graphData[2] = acceleration.z * 100
    
        setChart(graphLabels, values: graphData)
        
    }
    
    func outputRotData(rotation: CMRotationRate){

        graphData[3] = rotation.x * 100
        graphData[4] = rotation.y * 100
        graphData[5] = rotation.z * 100
        
        setChart(graphLabels, values: graphData)
        
    }

    
}

