//
//  Numbers.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 05/04/2023.
//

import Foundation

extension Optional {
    func toString() -> String{
        guard let this = self else{
            return "?"
        }
        return "\(this)"
    }
}
