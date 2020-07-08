//
//  PhotoSpot.swift
//  PhotoSpot
//
//  Created by Beatriz Novais on 02/07/20.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import Firebase

struct PhotoSpot {
    
    var documentID: String?
    let latitude: Double
    let longitude: Double
    var reportedDate: Date = Date()
}

extension PhotoSpot {
    
    init?(_ snapshot: QueryDocumentSnapshot) {
        guard let latitude = snapshot["latitude"] as? Double,
            let longitude = snapshot["longitude"] as? Double else {
                return nil
        }
        
        self.latitude = latitude
        self.longitude = longitude
        self.documentID = snapshot.documentID
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension PhotoSpot {
    
    func toDictonary() -> [String:Any] {
        return ["latitude": self.latitude, "longitude": self.longitude, "reportedDate": self.reportedDate.formatAsString()]
    }
}
