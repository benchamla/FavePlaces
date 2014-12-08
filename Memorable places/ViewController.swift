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
CLLocationManagerDelegate, UITextFieldDelegate {

    

    @IBOutlet weak var EffectAddView: UIVisualEffectView!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var NewNamePlace: UITextField!
    
    
    var manager:CLLocationManager!
    var annotation = MKPointAnnotation()
    var newTileAnnotation = ""
    var newLat: Double = 0
    var newLon: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        EffectAddView.hidden = true
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace != -1 {
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
            
         var annotationn = MKPointAnnotation()
        annotationn.coordinate = location
        annotationn.title = places[activePlace]["name"]
        myMap.addAnnotation(annotationn)
        }
        else{
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
            uilpgr.minimumPressDuration = 2.0
        myMap.addGestureRecognizer(uilpgr)
        
            
      
        
        
        
    }

    func action(gestureRecognizer:UIGestureRecognizer){
        
       var touchPoint = gestureRecognizer.locationInView(self.myMap)
       var newCoordinate = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
       
        
        annotation.coordinate = newCoordinate
        newLat = annotation.coordinate.latitude
        newLon = annotation.coordinate.longitude
        
        
        
        EffectAddView.hidden = false
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        newTileAnnotation = NewNamePlace.text
        EffectAddView.hidden = true
        annotation.title = newTileAnnotation
        myMap.addAnnotation(annotation)
        places.append(["name": NewNamePlace.text, "lat": "\(annotation.coordinate.latitude)", "lon": "\(annotation.coordinate.longitude)"])
        return true
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation
        
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        myMap.setRegion(region, animated: true)
      
        manager.stopUpdatingLocation()

        
        
        println(userLocation) 
    }

    @IBAction func findMePressed(sender: AnyObject) {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
}

