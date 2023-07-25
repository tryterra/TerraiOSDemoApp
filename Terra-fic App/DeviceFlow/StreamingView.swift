//
//  StreamingView.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 05/04/2023.
//

import Foundation
import SwiftUI
import TerraRTiOS
struct StreamingView: View{
    @Binding var path: [String]
    @State public var streamValue: Int = 0
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(alignment: .center, spacing: 0){
                ZStack{
                    Text("Select a Bluetooth Device").font(Font.custom("Poppins-Bold", size: 16))
                    HStack{
                        BackButton(path: $path).padding(.leading, 10)
                        Spacer()
                        Image("wearable").padding(.trailing, 10)
                    }
                }.padding(.top, 10)
                    .frame(width: geometry.size.width, height: 24, alignment: .center)
                HStack{
                    Image("date").scaleEffect(0.5)
                        .padding(.leading, 28)
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack {
                            ForEach(-2...2, id: \.self){i in
                                if (i == 0){
                                    Text("\(Date().toDayMonthDate())")
                                        .font(Font.custom("Poppins-Regular", size: 12))
                                        .foregroundColor(.black)
                                        .background(
                                            Rectangle()
                                                .fill(Color.init(.sRGB, red: 215/255, green: 235/255, blue:254/255, opacity: 1))
                                                .cornerRadius(31)
                                                .frame(width: 94, height: 34)
                                        )
                                        .frame(width: 94, height: 34)
                                }
                                else{
                                    Text("\(Date().addingTimeInterval(TimeInterval(86400 * i) ).toDate())")
                                        .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                                        .font(Font.custom("Poppins-Regular", size: 12))
                                        .padding(.leading, 22)
                                }
                            }
                        }
                    })
                    .frame(width: geometry.size.width * 0.7)
                    .padding(.trailing, 65)
                }.frame(width: geometry.size.width * 0.9, height: 34)
                    .padding(.top, 25)
                
                ZStack(alignment: .center){
                    Circle().fill(Color.init(.sRGB, red: 188/255, green: 224/255, blue: 254/255, opacity: 0.3))
                        .frame(width: geometry.size.width * 0.72, height: geometry.size.width * 0.72, alignment: .center)
                    Circle().fill(Color.init(.sRGB, red: 188/255, green: 224/255, blue: 254/255, opacity: 0.5))
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6, alignment: .center)
                    Circle().fill(Color.init(.sRGB, red: 188/255, green: 224/255, blue: 254/255, opacity: 1))
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5, alignment: .center)
                    HStack{
                        Text("\(streamValue)")
                            .font(.custom("Poppins-Bold", size: 63))
                            .foregroundColor(Color.init(.sRGB, red:48/255, green:164/255, blue: 251/255, opacity: 1))
                        VStack(alignment: .leading, spacing: 0 ){
                            Text("BPM")
                                .font(.custom("Poppins-Regular", size: 21))
                            HStack(spacing: 3){
                                Image("heart")
                                Text("Normal")
                                    .font(.custom("Poppins-Regular", size: 12.27))
                            }

                        }
                    }
                }.padding(.top, 24)
                VStack{
                    
                }
                Spacer()
                HStack{
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 83, height: 50)
                            .cornerRadius(9)
                        VStack{
                            HStack{
                                Text("88")
                                    .font(.custom("Poppins-Bold", size: 16))
                                    .foregroundColor(Color.init(.sRGB, red:48/255, green:164/255, blue: 251/255, opacity: 1))
                                Text("BPM")
                                    .font(.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                            }
                            Text("Avr")
                                .font(.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                        }
                    }
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 83, height: 50)
                            .cornerRadius(9)
                        VStack{
                            HStack{
                                Text("88")
                                    .font(.custom("Poppins-Bold", size: 16))
                                    .foregroundColor(Color.init(.sRGB, red:48/255, green:164/255, blue: 251/255, opacity: 1))
                                Text("BPM")
                                    .font(.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                            }
                            Text("Min")
                                .font(.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                        }
                    }
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 83, height: 50)
                            .cornerRadius(9)
                        VStack{
                            HStack{
                                Text("88")
                                    .font(.custom("Poppins-Bold", size: 16))
                                    .foregroundColor(Color.init(.sRGB, red:48/255, green:164/255, blue: 251/255, opacity: 1))
                                Text("BPM")
                                    .font(.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                            }
                            Text("Max")
                                .font(.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color.init(.sRGB, red: 143/255, green: 157/255, blue: 185/255, opacity: 1))
                        }
                    }
                }.frame(width: geometry.size.width * 0.8, alignment: .center)
            }
        }.navigationBarBackButtonHidden(true)
        .background(Color.init(.sRGB, red: 248/255, green: 250/255, blue: 255/255, opacity: 1), ignoresSafeAreaEdges: .all)
        .onAppear{
//            let token = generateToken(devId: DEVID, xAPIKey: XAPIKEY, userId: ScanDeviceView.terraRTiOS.getUserid()!)!.token
            ScanDeviceView.terraRTiOS.startRealtime(type: .BLE, dataType: [.HEART_RATE]){update in streamValue = Int(update.val ?? 0.0)}
        }
    }
    
    public func generateToken(devId: String, xAPIKey: String, userId: String) -> TokenPayload?{
        
            let url = URL(string: "https://ws.tryterra.co/auth/user?id=\(userId)")
            
            guard let requestUrl = url else {fatalError()}
            var request = URLRequest(url: requestUrl)
            var result: TokenPayload? = nil
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "terra.token.generation")
            request.httpMethod = "POST"
            request.setValue("*/*", forHTTPHeaderField: "Accept")
            request.setValue("keep-alive", forHTTPHeaderField: "Connection")
            request.setValue(devId, forHTTPHeaderField: "dev-id")
            request.setValue(xAPIKey, forHTTPHeaderField: "X-API-Key")
            
            let task = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data{
                    let decoder = JSONDecoder()
                    do{
                        result = try decoder.decode(TokenPayload.self, from: data)
                        group.leave()
                    }
                    catch{
                        print(error)
                        group.leave()
                    }
                }
            }
            group.enter()
            queue.async(group: group) {
                task.resume()
            }
            group.wait()
            return result
    }
}
