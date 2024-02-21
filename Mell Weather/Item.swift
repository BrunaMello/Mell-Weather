//
//  Item.swift
//  Mell Weather
//
//  Created by Bruna Mello on 21/02/2024.
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
