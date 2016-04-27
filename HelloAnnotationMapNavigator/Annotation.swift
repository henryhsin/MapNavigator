//
//  File.swift
//  HelloAnnotationMapNavigator
//
//  Created by 辛忠翰 on 2016/4/13.
//  Copyright © 2016年 Hsinhan. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation:NSObject, MKAnnotation{
    var coordinate :CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(theCoordinate: CLLocationCoordinate2D, theTitle: String, theSubtitle:String) {
        coordinate = theCoordinate
        title = theTitle
        subtitle = theSubtitle
        super.init()
    }
}