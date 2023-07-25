//
//  Date.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 05/04/2023.
//

import Foundation

extension Date{
    func toDayMonthDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: self)
    }
    
    func toDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
}
