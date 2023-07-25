//
//  ContentView.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import SwiftUI
import TerraiOS
struct ContentView: View {
    
    static public var terraManager: TerraManager? = nil
    
    @State var path: [String] = []
    
    init() {
        Terra.instance(devId: DEVID, referenceId: "TonyStarks") { manager, error in
            ContentView.terraManager = manager
            if let error = error{
                print(error)
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                Image("TERRA")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding([.bottom], 32)
                
                Button(action: {
                    path.append("widgetInfo")
                }, label:{
                    Text("Connect Widget")
                    .foregroundColor(Color.white)
                    .font(Font.custom("Poppins-Regular", size: 13))
                    .frame(width: 290, height: 50)
                }).background(
                    Rectangle()
                        .fill(Color.darkBackground)
                        .cornerRadius(6.5)
                )
                
                Button {
                    path.append("scanDevice")
                } label: {
                    Text("Connect Device")
                        .foregroundColor(Color.white)
                        .font(Font.custom("Poppins-Regular", size: 13))
                        .frame(width: 290, height: 50)
                }.background(
                    Rectangle()
                        .fill(Color.lightBackground)
                        .cornerRadius(6.5)
                ).padding([.top], 16)
            }
            .navigationDestination(for: String.self){ dest in
                switch dest{
                case "widgetInfo":
                    WidgetInfo(path: $path)
                case "requestData":
                    RequestData(path: $path)
                case "dataType":
                    DataRequestView(WidgetInfo.userId, RequestData.dataType!, WidgetInfo.resource!, $path)
                case "dataView":
                    DataView(startDate: DataRequestView.startDate_, endDate: DataRequestView.endDate_, userId: WidgetInfo.userId!, dataType: RequestData.dataType!, resource: WidgetInfo.resource!, path: $path)
                case "scanDevice":
                    ScanDeviceView(path: $path)
                case "streamView":
                    StreamingView(path: $path)
                default:
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
