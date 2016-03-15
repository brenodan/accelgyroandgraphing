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

    var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    @IBOutlet weak var zRotLabel: UILabel!
    @IBOutlet weak var yRotLabel: UILabel!
    @IBOutlet weak var xRotLabel: UILabel!
    @IBOutlet weak var zAccelLabel: UILabel!
    @IBOutlet weak var yAccelLabel: UILabel!
    @IBOutlet weak var xAccelLabel: UILabel!
    var months: [String]!
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
        
        months = ["X Accel", "Y Accel", "Z Accel", "X rot", "Y rot", "Z rot"]
        
        
        
        
        
        
        
    }

    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        ChartColorTemplates.vordiplom()
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        let ll = ChartLimitLine(limit: 0.0, label: "Zero")
        barChartView.rightAxis.addLimitLine(ll)
        
        
        
    }
    
    
    func outputAccData(acceleration: CMAcceleration){
        
        xAccelLabel?.text = "\(acceleration.x).2fg"
      
        
        yAccelLabel?.text = "\(acceleration.y).2fg"
     
        
        zAccelLabel?.text = "\(acceleration.z).2fg"
       
        unitsSold[0] = acceleration.x * 100
        unitsSold[1] = acceleration.y * 100
        unitsSold[2] = acceleration.z * 100
    
        print(unitsSold[0])
        setChart(months, values: unitsSold)
        
    }
    
    func outputRotData(rotation: CMRotationRate){
        
        
        xRotLabel?.text = "\(rotation.x).2fr/s"
      
        yRotLabel?.text = "\(rotation.y).2fr/s"
     
        zRotLabel?.text = "\(rotation.z).2fr/s"
      
        unitsSold[3] = rotation.x * 100
        unitsSold[4] = rotation.y * 100
        unitsSold[5] = rotation.z * 100
        setChart(months, values: unitsSold)
        
    }

    
}

