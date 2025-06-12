//
//  Item.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
