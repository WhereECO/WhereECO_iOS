//
//  Maker.swift
//  WhereECO_iOS
//
//  Created by κΉνμ on 2022/10/12.
//

import MapKit

class Marker: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
