//
//  WidgetInfo.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import Foundation
import SwiftUI

struct WidgetInfo: View{
    
    var widgetHandler = WidgetHandler()
    
    public static var userId: String? = nil
    public static var resource: String? = nil
    
    @Binding var path: [String]
    
    var body: some View{
        VStack{
            Image("widget_info")
            Text("Widget to connect your app to all wearables")
                .multilineTextAlignment(.center)
                .font(Font.custom("Poppins-Bold", size: 20))
                .frame(width: 261, height: 60)
                .padding([.top], 64)
            Text("Unlock the power of health data")
                .multilineTextAlignment(.center)
                .font(Font.custom("Poppins-Regular", size: 16))
                .frame(width: 296, height: 21)
                .padding([.top], 16)
            HStack{
                Circle().frame(width: 12, height: 12)
                Circle().fill(Color.lightGray).frame(width: 12, height: 12)
                    .padding([.leading], 4)
                Circle().fill(Color.lightGray).frame(width: 12, height: 12)
                    .padding([.leading], 4)
            }
            .padding([.top], 40)
            Button(action: {
                widgetHandler.displayWidget { success, _userId, _resource  in
                    if success {
                        WidgetInfo.userId = _userId
                        WidgetInfo.resource = _resource
                        path.append("requestData")
                    }
                }
            }, label: {
                Text("Continue")
                    .font(Font.custom("Poppins-Regular", size: 13))
                    .foregroundColor(Color.white)
                    .frame(width: 169, height: 33)
                    .background(
                        Rectangle()
                            .fill(Color.darkBackground)
                            .cornerRadius(6.5)
                    )
                    .padding([.top], 105)
            }).padding()
        }
    }
}


//struct WidgetInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetInfo()
//    }
//}
