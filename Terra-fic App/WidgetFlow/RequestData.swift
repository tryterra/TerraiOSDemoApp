//
//  RequestData.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import Foundation
import SwiftUI

struct DataType: View{
        
    public let type: String
    public let userId: String?
    
    @Binding var path: [String]
    
    init(_ userId: String?, _ type: String, _ path: Binding<[String]>){
        self.userId = userId
        self.type = type
        self._path = path
    }
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.white)
                .cornerRadius(16)
            VStack{
                Image(self.type)
                Text(self.type)
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color.lightText)
            }
        }.frame(width: 163.5, height: 150, alignment: .center).shadow(color: Color.blockShadow, radius:6, x: 0, y: 2)
    }
}

struct RequestData: View{
    
    @Binding var path: [String]
    
    public static var userId: String?

    
    public static var dataType: String? = nil
    
    @State var showRequest: Bool = false
    
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                ZStack{
                    Text("Request Data").font(Font.custom("Poppins-Bold", size: 16))
                    HStack{
                        BackButton(path: $path).padding(.leading, 10)
                        Spacer()
                    }
                }.padding(.top, 10)
                    .frame(width: geometry.size.width, height: 24, alignment: .center)
                HStack{
                    DataType(RequestData.userId, "Body", $path).onTapGesture {
                        RequestData.dataType = "body"
                        path.append("dataType")
                    }
                    DataType(RequestData.userId, "Daily", $path).padding(.leading, 16.5)
                        .onTapGesture {
                            RequestData.dataType = "daily"
                            path.append("dataType")
                        }
                }.padding(.top, 36)
                HStack{
                    DataType(RequestData.userId, "Activity", $path)
                        .onTapGesture {
                            RequestData.dataType = "activity"
                            path.append("dataType")
                        }
                    DataType(RequestData.userId, "Sleep", $path).padding(.leading, 16.5)
                        .onTapGesture {
                            RequestData.dataType = "sleep"
                            path.append("dataType")
                        }
                }.padding(.top, 16)
                HStack{
                    DataType(RequestData.userId, "Menstruation", $path)
                        .onTapGesture {
                            RequestData.dataType = "menstruation"
                            path.append("dataType")
                        }
                    DataType(RequestData.userId, "Nutrition", $path).padding(.leading, 16.5)
                        .onTapGesture {
                            RequestData.dataType = "nutrition"
                            path.append("dataType")
                        }
                }.padding(.top, 16)
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }.background(Color.appBackground, ignoresSafeAreaEdges: .vertical)
            .navigationBarBackButtonHidden(true)
            
    }
}

//
//struct RequestData_Previews: PreviewProvider {
//
//    static var previews: some View {
//       RequestData()
//    }
//}
