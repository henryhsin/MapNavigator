//
//  ViewController.swift
//  HelloAnnotationMapNavigator
//
//  Created by 辛忠翰 on 2016/4/13.
//  Copyright © 2016年 Hsinhan. All rights reserved.
//add annotation
//區分不同的annotation，並幫不同的annotation換不同的顏色(mapView的viewForAnotation)
//navigator：利用MKPlaceMark來導航

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController, MKMapViewDelegate{
    var annotation1:MyAnnotation?
    var annotation2:MyAnnotation?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.addAnnotationForMapView(mapView)
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnnotationForMapView(mapView: MKMapView){
         annotation1 = MyAnnotation(theCoordinate: CLLocationCoordinate2D(latitude: 24.968299, longitude: 121.195464), theTitle: "中央大學", theSubtitle: "正門")
         annotation2 = MyAnnotation(theCoordinate: CLLocationCoordinate2D(latitude: 24.965946, longitude: 121.191130), theTitle: "中央大學", theSubtitle: "後門")
        mapView.addAnnotations(Array(arrayLiteral: annotation1!,annotation2!))
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {//用來改annotation的圖樣和新增對話泡泡裡的button
        if annotation.subtitle! == "正門" {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "gate")
            pin.pinTintColor = UIColor.purpleColor()
            pin.canShowCallout = true//按了這個pin後會出現對話泡泡
            pin.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)//這個對話泡泡中，新增一個button，這個button為buttonType中的驚嘆號
            return pin
        }else if annotation.subtitle! == "後門" {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "backDoor")
            pin.pinTintColor = UIColor.blueColor()
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            return pin
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {//當點擊annotation中的callOut泡泡中的！button後，該做的事情。此外剛剛為不同的annotation設定的reusedIdentifier就可以在此當作annotation的ID。接下來我們會在此處撰寫導航的程式碼
        if view.reuseIdentifier == "gate" {
            print("gate")
            let ncuGatePlacemark = MKPlacemark(coordinate: annotation1!.coordinate, addressDictionary: nil)//MKPlacemark裡面存放著剛剛設定的annotation的經緯座標
            
            let destination1 = MKMapItem(placemark: ncuGatePlacemark)//放置導航的起始位置
            destination1.name = "中央大學正門口"//指定當跳到apple原生的導航app時的地名
            destination1.openInMapsWithLaunchOptions(Dictionary(dictionaryLiteral: (MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsDirectionsModeKey)))//需加入導航模式，這邊選用開車糢式，切記要用dictionary的方式加入
            
        }else if view.reuseIdentifier == "backDoor" {
            print("backdoor")
        }
    }
}

