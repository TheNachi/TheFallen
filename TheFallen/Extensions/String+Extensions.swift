//
//  String+Extensions.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 24/09/2021.
//

import Foundation

extension String {
    
    func toDate(with format: String = "YYYY-dd-MM") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
        
    }
    
    func dateStringConversation() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, YYYY"

        let stringPrefix = String(self.prefix(10))

        if let date = dateFormatterGet.date(from: stringPrefix) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
    
    
}
