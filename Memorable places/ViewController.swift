//
//  ViewController.swift
//  Memorable places
//
//  Created by ben on 03/12/2014.
//  Copyright (c) 2014 Ben Chamla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,
CLLocationManagerDelegate {

    

    @IBOutlet weak var myMap: MKMapView!
    
    var manager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let  lat = NSString(string: places[activePlace]["lat"]!).doubleValue
       
        let lon = NSString(string: places[activePlace]["lon"]!).doubleValue
        var latitude:CLLocationDegrees = lat
        var longitude:CLLocationDegrees = lon
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        myMap.setRegion(region, animated: true)
        
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
       
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation
        
        println(userLocation) 
    }

    @IBAction func findMePressed(sender: AnyObject) {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

