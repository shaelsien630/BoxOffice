//
//  Formatter.swift
//  BoxOffice
//
//  Created by 최서희 on 8/26/24.
//

import Foundation

extension Date {
    static var lastWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
    }
    
    func toString(format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

extension String {
    func asDate(format: DateFormat = .yyyyMMddHypen) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

enum DateFormat: String {
    case yyyyMMdd = "yyyyMMdd"
    case yyyyMMddDot = "yyyy.MM.dd"
    case yyyyMMddHypen = "yyyy-MM-dd"
}
