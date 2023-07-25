//
//  RemoveBackgroundColor.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 01/04/2023.
//

import Foundation
import SwiftUI

struct RemoveBackgroundColor: UIViewRepresentable{
    func makeUIView(context: Context) -> UIView{
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}
