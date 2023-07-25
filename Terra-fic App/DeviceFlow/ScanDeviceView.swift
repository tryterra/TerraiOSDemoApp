//
//  ScanDeviceView.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 04/04/2023.
//

import Foundation
import SwiftUI
import TerraRTiOS

public struct TokenPayload: Decodable{
    let token: String
}


struct ScanDeviceView: View{
    
    static public var terraRTiOS = TerraRT(devId: DEVID, referenceId: "TonyStark") { success in
        if !success {
            print("Failed to instantiate TerraRT")
        }
        UserDefaults.standard.set("debug", forKey: "co.tryterra.terra.logging.level")
    }
    
    @Binding var path: [String]
    
    @State var displayScanWidget: Bool = false
    
    var body: some View{
        GeometryReader{geometry in
            VStack(spacing: 0){
                ZStack{
                    Text("Select a Bluetooth Device").font(Font.custom("Poppins-Bold", size: 16))
                    HStack{
                        BackButton(path: $path).padding(.leading, 10)
                        Spacer()
                    }
                }.padding(.top, 10)
                    .frame(width: geometry.size.width, height: 24, alignment: .center)
                HStack{
                    VStack(alignment: .leading){
                        Text("This uses bluetooth to connect your device to Terra.")
                            .font(Font.custom("Poppins-Light", size: 11))
                            .foregroundColor(Color.lightText)
                        Text("Kindly turn on bluetooth on your device to connect.")
                            .font(Font.custom("Poppins-Light", size: 11))
                            .foregroundColor(Color.lightText)
                    }
                    Spacer()
                }.frame(width: geometry.size.width * 0.9)
                .padding(.top, 20)
                ZStack(alignment:.center){
                    Rectangle()
                        .fill(.white)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                        .cornerRadius(16)
                        .shadow(color: Color.blockShadow, radius: 6, x: 0, y: 2)
                    VStack(alignment: .leading, spacing: 0){
                        Image("bluetooth")
                            .padding(.top, 60)
                        Text("Bluetooth is off")
                            .font(Font.custom("Poppins-SemiBold", size: 24))
                            .padding(.top, 48)
                        Text("You must turn on bluetooth to use this feature")
                            .font(Font.custom("Poppins-Light", size: 11))
                            .foregroundColor(Color.lightText)
                            .padding(.top, 10)
                        Button(action: {
                            if let _ = ScanDeviceView.terraRTiOS.getUserid(){
                                displayScanWidget.toggle()
                            }
                            else{
                                ScanDeviceView.terraRTiOS.initConnection(token: WidgetHandler.generateAuthToken() ?? ""){success in
                                    if success{
                                        displayScanWidget.toggle()
                                    }
                                }
                            }
                        }, label: {
                            Text("Turn On")
                                .font(Font.custom("Poppins-SemiBold", size: 13))
                                .foregroundColor(.white)
                                .background(
                                    Rectangle()
                                        .fill(Color.darkBackground)
                                        .cornerRadius(6.5)
                                        .frame(width: 169, height: 33)
                                ).frame(width: 169, height: 33)
                        }).padding(.top, 33)
                        Spacer()
                    }
                }.frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                    .padding(.top, 18)
            }.navigationBarHidden(true)
        }.background(Color.appBackground, ignoresSafeAreaEdges: .all)
        .sheet(isPresented: $displayScanWidget) {
            ScanDeviceView.terraRTiOS.startBluetoothScan(type: .BLE, bluetoothLowEnergyFromCache: false){succ in
                displayScanWidget.toggle()
                if succ{
                    path.append("streamView")
                }
            }
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
