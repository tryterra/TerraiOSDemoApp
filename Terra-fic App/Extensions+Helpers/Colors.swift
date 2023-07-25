//
//  Colors.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import Foundation
import SwiftUI

extension Color{
    public static var darkBackground: Color{
        Color.init(.sRGB, red: 30/255, green: 41/255, blue: 58/255, opacity: 1)
    }
    
    public static var lightBackground: Color{
        Color.init(.sRGB, red: 96/255, green: 165/255, blue: 250/255, opacity: 1)
    }
    
    public static var lightGray: Color{
        Color.init(.sRGB, red: 217/255, green: 217/255, blue: 217/255, opacity: 1)
    }
    
    public static var appBackground: Color{
        Color.init(.sRGB, red: 0.96, green: 0.96, blue: 0.96, opacity: 1.0)
    }
    
    public static var blockShadow: Color{
        Color.init(.sRGB, white: 0, opacity: 0.1)
    }
    
    public static var lightBlue: Color{
        Color.init(.sRGB, red: 245/255, green: 249/255, blue: 1, opacity: 1)
    }
    
    public static var lightText: Color{
        Color.init(.sRGB, red: 102/255, green: 102/255, blue: 102/255, opacity: 1)
    }
}
