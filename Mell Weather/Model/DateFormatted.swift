//
//  DateFormatted.swift
//  Mell Weather
//
//  Created by Bruna Mello on 21/02/2024.
//

import Foundation
import SwiftUI

extension Date {
    func formatAsAbbreviatedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    func formatAsAbbreviatedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}
