//
//  DateHelper.swift
//  JournaliOS14CloudKit
//
//  Created by Nick Reichard on 8/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

extension Date {
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
}
