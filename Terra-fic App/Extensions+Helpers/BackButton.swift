//
//  BackButton.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 02/04/2023.
//

import SwiftUI
import Foundation


struct BackButton: View{
    @Binding var path: [String]
    
    var body: some View{
        ZStack{
            Circle()
                .strokeBorder(Color.init(.sRGB, red: 0.92, green: 0.92, blue: 0.92, opacity: 1), lineWidth: 1)
                .background(Circle().fill(.white))
            Image(systemName: "arrow.backward").foregroundColor(Color.black)
        }.frame(width: 31, height: 31, alignment: .center)
            .onTapGesture {
                let _ = path.popLast()
            }
    }
}
