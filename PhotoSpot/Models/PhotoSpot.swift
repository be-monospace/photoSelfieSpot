//
//  PhotoSpot.swift
//  PhotoSpot
//
//  Created by Beatriz Novais on 02/07/20.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation

struct PhotoSpot {
    
    var documentID: String?
    let latitude: Double
    let longitude: Double
    var reportedDate: Date = Date()
}

extension PhotoSpot {
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension PhotoSpot {
    
    func toDictonary() -> [String:Any] {
        return ["latitude": self.latitude, "longitude": self.longitude, "reportedDate": "hardcode"]
    }
}
