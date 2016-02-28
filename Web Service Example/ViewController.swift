//
//  ViewController.swift
//  Web Service Example
//
//  Created by Deekshita Amaravadi on 2/14/16.
//  Copyright © 2016 Deekshita Amaravadi. All rights reserved.
//

import UIKit

import SwiftyJSON

import LTMorphingLabel

class ViewController: UIViewController {
    
    @IBOutlet weak var forecastLabel: LTMorphingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		forecastLabel.morphingEffect = .Pixelate
        self.forecastLabel.text = ""
		
        //instantiate a gray Activity Indicator View
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        //add the activity to the ViewController's view
        view.addSubview(activityIndicatorView)
        //position the Activity Indicator View in the center of the view
        activityIndicatorView.center = view.center
        //tell the Activity Indicator View to begin animating
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPSessionManager()
        
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=2f3c40ad7ab3b9d444c8eb7b05691f22",
            parameters: nil,
            progress: nil,
            success: { (operation,responseObject) in
            
                let json = JSON(responseObject!)
                if let forecast = json["list"][0]["weather"][0]["description"].string {
                    self.forecastLabel.text = forecast
                }
                activityIndicatorView.removeFromSuperview()
                
            },
            failure: { (operation,error) in
                print("Error: " + error.localizedDescription)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

