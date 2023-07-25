//
//  DataView.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 01/04/2023.
//

import SwiftUI
import TerraiOS

struct ConnectWearables: View{
    @Binding var showConnectWearables: Bool
    
    @Binding var path: [String]
    let dragGesture = DragGesture(minimumDistance: 5, coordinateSpace: .local)
    var body: some View{
        GeometryReader{geometry in
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width,  height: geometry.size.height * 0.27)
                        .ignoresSafeArea()
                        .cornerRadius(16)
                    VStack(spacing: 0){
                        Image("line")
                            .padding(.top, 14)
                        Button(action: {
                            path = ["widgetInfo"]
                        }, label: {
                            Text("Connect Widget")
                                .font(Font.custom("Poppins-SemiBold", size: 13))
                                .foregroundColor(.white)
                                .background(
                                    Rectangle()
                                        .fill(Color.darkBackground)
                                        .frame(width: geometry.size.width * 0.78 , height: geometry.size.height * 0.06, alignment: .center)
                                        .cornerRadius(6.5)
                                ).frame(width: geometry.size.width * 0.78 , height: geometry.size.height * 0.06, alignment: .center)
                                .padding(.top, 18)
                        })
                        Button(action: {
                            path = ["scanDevice"]
                        }, label: {
                            Text("Connect a Device")
                                .font(Font.custom("Poppins-SemiBold", size: 13))
                                .foregroundColor(.white)
                                .background(
                                    Rectangle()
                                        .fill(Color.lightBackground)
                                        .frame(width: geometry.size.width * 0.78 , height: geometry.size.height * 0.06, alignment: .center)
                                        .cornerRadius(6.5)
                                ).frame(width: geometry.size.width * 0.78 , height: geometry.size.height * 0.06, alignment: .center)
                                .padding(.top, 8)
                        })
                        Text("Cancel")
                            .font(Font.custom("Poppins-SemiBold", size: 13))
                            .foregroundColor(.black)
                            .onTapGesture {
                                showConnectWearables.toggle()
                            }
                            .padding(.top, 16)
                        Spacer()
                    }.frame(height:geometry.size.height * 0.27, alignment: .center)
                }
            }
        }.ignoresSafeArea(.all)
    }
}

struct DataField: View{
    let name: String
    let value: String
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    var body: some View{
        HStack{
            Text(name).font(Font.custom("Poppins-Regular", size: 14))
                .padding(.leading, 16)
            Spacer()
            Text(value).font(Font.custom("Poppins-SemiBold", size: 14))
                .padding(.trailing, 16)
        }
    }
}

struct DataDisplay: View{
    @Binding var requestingData: Bool
    
    var userId: String
    var resource: String
    var dataType: String
    
    static var dataToDisplay: [DataField] = []
    
    init(requestingData: Binding<Bool>, userId: String, resource: String, dataType: String) {
        self.userId = userId
        self.resource = resource
        self.dataType = dataType
        self._requestingData = requestingData
    }
    
    
    var body: some View{
        GeometryReader{geometry in
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(16)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .shadow(color: Color.blockShadow, radius:6, x: 0, y: 2)
                if (requestingData){
                    ProgressView("Requesting Data")
                }
                else{
                    LazyVStack(spacing: 0){
                        DataDisplay.dataToDisplay[0]
                            .background(
                                Rectangle()
                                    .fill(Color.white)
                                    .clipShape(RoundedCorner(radius: 16, corners: [.topLeft, .topRight]))
                                    .frame(width: geometry.size.width,  height: geometry.size.height/10, alignment: .center)
                            )
                            .frame(width: geometry.size.width,  height: geometry.size.height/10, alignment: .center)
                        ForEach(1...8, id: \.self){i in
                            DataDisplay.dataToDisplay[i]
                                .background(
                                    Rectangle()
                                        .fill(i % 2 == 0 ? Color.white : Color.lightBlue)
                                        .frame(width: geometry.size.width,  height: geometry.size.height/10, alignment: .center)
                                )
                                .frame(width: geometry.size.width,  height: geometry.size.height/10, alignment: .center)
                        }
                        DataDisplay.dataToDisplay[9]
                            .background(
                                Rectangle()
                                    .fill(Color.lightBlue)
                                    .clipShape(RoundedCorner(radius: 16, corners: [.bottomLeft, .bottomRight]))
                                    .frame(width: geometry.size.width,  height: geometry.size.height/10, alignment: .center)
                            )
                            .frame(width: geometry.size.width,  height: geometry.size.height/10, alignment: .center)
                    }
                }
            }.frame(alignment: .center)
        }
    }
}


struct DataView: View {
    
    public static var startDate_: Date = Date()
    public static var endDate_: Date = Date()
    
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    var userId: String
    var dataType: String
    var resource: String
    
    @State var showStartDatePicker: Bool = false
    @State var showEndDatePicker: Bool = false
    @State var connectWearable: Bool = false
        
    @Binding var path: [String]
    
    @State var requestingData: Bool = true
                 
    public static var data: Any? = nil
    
    init(startDate: Date, endDate: Date, userId: String, dataType: String, resource: String, path: Binding<[String]>) {
        DataView.startDate_ = startDate
        DataView.endDate_ = endDate
        self.userId = userId
        self.dataType = dataType
        self.resource = resource
        self._path = path
    }
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                ZStack{
                    HStack{
                        BackButton(path: $path).padding(.leading, 10)
                        Spacer()
                    }
                    Text("\(dataType.capitalized) Data").font(Font.custom("Poppins-Bold", size: 16))
                }.padding(.top, 10)
                    .frame(width: geometry.size.width, height: 24, alignment: .center)
                HStack{
                    ZStack{
                        Rectangle()
                            .strokeBorder(Color.init(.sRGB, red: 0.92, green: 0.92, blue: 0.92, opacity: 1), lineWidth: 1)
                            .background(.white)
                            .cornerRadius(10)
                        VStack(spacing: 0){
                            HStack{
                                Text("From: ").font(Font.custom("Poppins-Regular", size: 12)).padding(.leading, 12)
                                    .foregroundColor(Color.init(.sRGB, red: 102/255, green: 102/255, blue: 102/255, opacity: 1))
                                Spacer()
                            }.padding(.top, 5)
                            HStack{
                                Text(ISO8601DateFormatter.string(from: startDate, timeZone: TimeZone.current, formatOptions: [.withDay, .withYear, .withMonth, .withDashSeparatorInDate])).font(Font.custom("Poppins-Regular", size: 14)).padding(.leading, 12)
                                    .onTapGesture {
                                        showStartDatePicker.toggle()
                                    }
                                Spacer()
                            }.padding(.bottom, 5)
                                .padding(.top, 2)
                        }.frame(alignment: .center)
                    }.frame(width: geometry.size.width * 0.44, height: 30, alignment: .center).padding(.top, 20)
                    Spacer()
                    ZStack{
                        Rectangle()
                            .strokeBorder(Color.init(.sRGB, red: 0.92, green: 0.92, blue: 0.92, opacity: 1), lineWidth: 1)
                            .background(.white)
                            .cornerRadius(10)
                        VStack(spacing: 0){
                            HStack{
                                Text("To: ").font(Font.custom("Poppins-Regular", size: 12)).padding(.leading, 12)
                                    .foregroundColor(Color.init(.sRGB, red: 102/255, green: 102/255, blue: 102/255, opacity: 1))
                                Spacer()
                            }
                            .padding(.top, 5)
                            HStack{
                                Text(ISO8601DateFormatter.string(from: endDate, timeZone: TimeZone.current, formatOptions: [.withDay, .withYear, .withMonth, .withDashSeparatorInDate])).font(Font.custom("Poppins-Regular", size: 14)).padding(.leading, 12)
                                    .onTapGesture {
                                        showEndDatePicker.toggle()
                                    }
                                Spacer()
                            }.padding(.bottom, 5)
                                .padding(.top, 2)
                        }.frame(alignment: .center)
                    }.frame(width: geometry.size.width * 0.44, height: 30, alignment: .center).padding(.top, 20)
                        .padding(.leading, 9)
                }.frame(width: geometry.size.width * 0.9)
                    .padding(.top, 20)
                DataDisplay(requestingData: $requestingData, userId: userId, resource: resource, dataType: dataType)
                    .padding(.top, 20)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.73, alignment: .center)
                HStack{
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(16)
                            .frame(width: geometry.size.width * 0.44, height: 58)
                        HStack{
                            Image("wearable")
                            Text("Connect").font(Font.custom("Poppins-Regular", size: 14))
                        }
                    }.frame(width: geometry.size.width * 0.44, height: 58, alignment: .center)
                        .shadow(color: Color.blockShadow, radius:6, x: 0, y: 2)
                        .onTapGesture {
                            connectWearable.toggle()
                        }

                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(16)
                            .frame(width: geometry.size.width * 0.44, height: 58)
                        HStack{
                            Image("files")
                            Text("Request Data").font(Font.custom("Poppins-Regular", size: 14))
                                .onTapGesture {
                                    requestingData = true
                                    makeRequestToTerra{
                                        requestingData.toggle()
                                    }
                                }
                        }
                    }.frame(width: geometry.size.width * 0.44, height: 58, alignment: .center)
                        .shadow(color: Color.blockShadow, radius:6, x: 0, y: 2)

                }.frame(width: geometry.size.width * 0.9)
                    .padding(.top, 15)
                Spacer()
            }
            .background(Color.appBackground, ignoresSafeAreaEdges: .all)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                makeRequestToTerra{
                    requestingData.toggle()
                }
            }
            .sheet(isPresented: $showStartDatePicker, content: {
                DatePickerView(showPicker: $showStartDatePicker, shownDate: $startDate)
                    .background(RemoveBackgroundColor())
                    .onDisappear{
                        DataView.startDate_ = startDate
                    }
            })
            .sheet(isPresented: $showEndDatePicker, content: {
                DatePickerView(showPicker: $showEndDatePicker, shownDate: $endDate)
                    .background(RemoveBackgroundColor())
                    .onDisappear{
                        DataView.endDate_ = endDate
                    }
            })
            .sheet(isPresented: $connectWearable) {
                ConnectWearables(showConnectWearables: $connectWearable, path: $path)
                    .background(RemoveBackgroundColor())
            }
            
        }.onAppear{
            startDate = DataView.startDate_
            endDate = DataView.endDate_
        }
    }
    
    func makeRequestToTerra(completion: @escaping() -> Void){
        let client = TerraClient(userId: userId, devId: DEVID, xAPIKey: XAPIKEY)
        DataDisplay.dataToDisplay = []

        switch dataType{
        case "activity":
            if (resource == "APPLE"){
                ContentView.terraManager?.getActivity(type: .APPLE_HEALTH, startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false){success,data,error in
                    let lastActivity = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Start", value: (lastActivity?.metadata?.start_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "End", value: (lastActivity?.metadata?.end_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Name", value: (lastActivity?.metadata?.name).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Duration", value: (lastActivity?.active_durations_data?.activity_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Calories", value: (lastActivity?.calories_data?.total_burned_calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value: (lastActivity?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value: (lastActivity?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value: (lastActivity?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Distance", value: (lastActivity?.distance_data?.summary?.distance_meters).toString() + " m"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Steps", value: (lastActivity?.distance_data?.summary?.steps).toString()))
                    completion()
                }
            }
            else{
                client.getActivity(startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false) { data in
                    let lastActivity = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Start", value: (lastActivity?.metadata?.start_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "End", value: (lastActivity?.metadata?.end_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Name", value: (lastActivity?.metadata?.name).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Duration", value: (lastActivity?.active_durations_data?.activity_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Calories", value: (lastActivity?.calories_data?.total_burned_calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value: (lastActivity?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value: (lastActivity?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value: (lastActivity?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Distance", value: (lastActivity?.distance_data?.summary?.distance_meters).toString() + " m"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Steps", value: (lastActivity?.distance_data?.summary?.steps).toString()))
                    completion()
                }
            }
        case "body":
            if (resource == "APPLE"){
                ContentView.terraManager?.getBody(type: .APPLE_HEALTH, startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false){success,data,error in
                    let lastBodyPayload = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Weight", value: (lastBodyPayload?.measurements_data?.measurements?.last?.weight_kg).toString() + " kg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Height", value: (lastBodyPayload?.measurements_data?.measurements?.last?.height_cm).toString() + " cm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Blood Pressure (Dia)", value: (lastBodyPayload?.blood_pressure_data?.blood_pressure_samples?.last?.diastolic_bp).toString() + " mmHg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Blood Pressure (Sys)", value: (lastBodyPayload?.blood_pressure_data?.blood_pressure_samples?.last?.systolic_bp).toString() + " mmHg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg Blood Glucose", value: (lastBodyPayload?.glucose_data?.day_avg_blood_glucose_mg_per_dL).toString() + " mg/Dl"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value: (lastBodyPayload?.heart_data?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value: (lastBodyPayload?.heart_data?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value: (lastBodyPayload?.heart_data?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg Spo2", value: (lastBodyPayload?.oxygen_data?.avg_saturation_percentage).toString() + " %"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg Vo2Max", value: (lastBodyPayload?.oxygen_data?.vo2max_ml_per_min_per_kg).toString() + " ml/min/kg"))
                    completion()
                }
            }
            else{
                client.getBody(startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false) { data in
                    let lastBodyPayload = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Weight", value: (lastBodyPayload?.measurements_data?.measurements?.last?.weight_kg).toString() + " kg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Height", value: (lastBodyPayload?.measurements_data?.measurements?.last?.height_cm).toString() + " cm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Blood Pressure (Dia)", value: (lastBodyPayload?.blood_pressure_data?.blood_pressure_samples?.last?.diastolic_bp).toString() + " mmHg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Blood Pressure (Sys)", value: (lastBodyPayload?.blood_pressure_data?.blood_pressure_samples?.last?.systolic_bp).toString() + " mmHg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg Blood Glucose", value: (lastBodyPayload?.glucose_data?.day_avg_blood_glucose_mg_per_dL).toString() + " mg/Dl"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value: (lastBodyPayload?.heart_data?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value: (lastBodyPayload?.heart_data?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value: (lastBodyPayload?.heart_data?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg Spo2", value: (lastBodyPayload?.oxygen_data?.avg_saturation_percentage).toString() + " %"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg Vo2Max", value: (lastBodyPayload?.oxygen_data?.vo2max_ml_per_min_per_kg).toString() + " ml/min/kg"))
                    completion()
                }
            }
        case "sleep":
            if (resource == "APPLE"){
                ContentView.terraManager?.getSleep(type: .APPLE_HEALTH, startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false){success,data,error in
                    let lastSleepSession = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Start", value: (lastSleepSession?.metadata?.start_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "End", value: (lastSleepSession?.metadata?.end_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total REM", value: (lastSleepSession?.sleep_durations_data?.asleep?.duration_REM_sleep_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Deep", value: (lastSleepSession?.sleep_durations_data?.asleep?.duration_deep_sleep_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Light", value: (lastSleepSession?.sleep_durations_data?.asleep?.duration_light_sleep_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Awake", value: (lastSleepSession?.sleep_durations_data?.awake?.duration_awake_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value: (lastSleepSession?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value: (lastSleepSession?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value: (lastSleepSession?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HRV", value: (lastSleepSession?.heart_rate_data?.summary?.avg_hrv_sdnn).toString() + " ms"))
                    completion()
                }
            }
            else{
                client.getSleep(startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false) { data in
                    let lastSleepSession = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Start", value: (lastSleepSession?.metadata?.start_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "End", value: (lastSleepSession?.metadata?.end_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total REM", value: (lastSleepSession?.sleep_durations_data?.asleep?.duration_REM_sleep_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Deep", value: (lastSleepSession?.sleep_durations_data?.asleep?.duration_deep_sleep_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Light", value: (lastSleepSession?.sleep_durations_data?.asleep?.duration_light_sleep_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Awake", value: (lastSleepSession?.sleep_durations_data?.awake?.duration_awake_state_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value: (lastSleepSession?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value: (lastSleepSession?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value: (lastSleepSession?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HRV", value: (lastSleepSession?.heart_rate_data?.summary?.avg_hrv_rmssd).toString() + " ms"))
                    completion()
                }
            }
        case "daily":
            if (resource == "APPLE"){
                ContentView.terraManager?.getDaily(type: .APPLE_HEALTH, startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false){success,data,error in
                    let lastDailyPayload = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Steps", value:  (lastDailyPayload?.distance_data?.summary?.steps).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Floors Climbed", value:  (lastDailyPayload?.distance_data?.summary?.floors_climbed).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Active Duration", value:  (lastDailyPayload?.active_durations_data?.activity_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Calories", value:  (lastDailyPayload?.calories_data?.total_burned_calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Distance", value:  (lastDailyPayload?.distance_data?.summary?.distance_meters).toString() + " m"))
                    DataDisplay.dataToDisplay.append(DataField(name: "BMR Calories", value:  (lastDailyPayload?.calories_data?.BMR_calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value:  (lastDailyPayload?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value:  (lastDailyPayload?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value:  (lastDailyPayload?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HRV", value:  (lastDailyPayload?.heart_rate_data?.summary?.avg_hrv_sdnn).toString() + " ms"))
                    completion()
                }
            }
            else{
                client.getDaily(startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false) { data in
                    let lastDailyPayload = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Steps", value:  (lastDailyPayload?.distance_data?.summary?.steps).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Floors Climbed", value:  (lastDailyPayload?.distance_data?.summary?.floors_climbed).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Active Duration", value:  (lastDailyPayload?.active_durations_data?.activity_seconds).toString() + " s"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Calories", value:  (lastDailyPayload?.calories_data?.total_burned_calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Total Distance", value:  (lastDailyPayload?.distance_data?.summary?.distance_meters).toString() + " m"))
                    DataDisplay.dataToDisplay.append(DataField(name: "BMR Calories", value:  (lastDailyPayload?.calories_data?.BMR_calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HR", value:  (lastDailyPayload?.heart_rate_data?.summary?.avg_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Min HR", value:  (lastDailyPayload?.heart_rate_data?.summary?.min_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Max HR", value:  (lastDailyPayload?.heart_rate_data?.summary?.max_hr_bpm).toString() + " bpm"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Avg HRV", value:  (lastDailyPayload?.heart_rate_data?.summary?.avg_hrv_rmssd).toString() + " ms"))
                    completion()
                }
            }
        case "menstruation":
            if (resource == "APPLE"){
                ContentView.terraManager?.getMenstruation(type: .APPLE_HEALTH, startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false){success,data,error in
                    let lastMenstruation = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Is Predicted Cycle", value: (lastMenstruation?.menstruation_data?.is_predicted_cycle).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Last Update", value: (lastMenstruation?.menstruation_data?.last_updated_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Current Phase", value: (lastMenstruation?.menstruation_data?.current_phase).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Cycle Length", value: (lastMenstruation?.menstruation_data?.cycle_length_days).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Day in Cycle", value: (lastMenstruation?.menstruation_data?.day_in_cycle).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Days until next phase", value: (lastMenstruation?.menstruation_data?.days_until_next_phase).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Length of current phase", value: (lastMenstruation?.menstruation_data?.length_of_current_phase_day).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Period Length", value: (lastMenstruation?.menstruation_data?.period_length_days).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Period Start Date", value: (lastMenstruation?.menstruation_data?.period_start_date).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Predicted Cycle Length", value: (lastMenstruation?.menstruation_data?.predicted_cycle_length_days).toString()))
                    completion()
                }
            }
            else{
                client.getMenstruation(startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false) { data in
                    let lastMenstruation = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Is Predicted Cycle", value: (lastMenstruation?.menstruation_data?.is_predicted_cycle).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Last Update", value: (lastMenstruation?.menstruation_data?.last_updated_time).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Current Phase", value: (lastMenstruation?.menstruation_data?.current_phase).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Cycle Length", value: (lastMenstruation?.menstruation_data?.cycle_length_days).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Day in Cycle", value: (lastMenstruation?.menstruation_data?.day_in_cycle).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Days until next phase", value: (lastMenstruation?.menstruation_data?.days_until_next_phase).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Length of current phase", value: (lastMenstruation?.menstruation_data?.length_of_current_phase_day).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Period Length", value: (lastMenstruation?.menstruation_data?.period_length_days).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Period Start Date", value: (lastMenstruation?.menstruation_data?.period_start_date).toString()))
                    DataDisplay.dataToDisplay.append(DataField(name: "Predicted Cycle Length", value: (lastMenstruation?.menstruation_data?.predicted_cycle_length_days).toString()))
                    completion()
                }
            }
        case "nutrition":
            if (resource == "APPLE"){
                ContentView.terraManager?.getNutrition(type: .APPLE_HEALTH, startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false){success,data,error in
                    let lastNutritionData = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Calories",  value:  (lastNutritionData?.summary?.macros?.calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Carbohydrates",  value:  (lastNutritionData?.summary?.macros?.carbohydrates_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Protein",  value:  (lastNutritionData?.summary?.macros?.protein_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Sugar",  value:  (lastNutritionData?.summary?.macros?.sugar_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Fat",  value:  (lastNutritionData?.summary?.macros?.fat_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Cholesterol",  value:  (lastNutritionData?.summary?.macros?.cholesterol_mg).toString()  + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin A",  value:  (lastNutritionData?.summary?.micros?.vitamin_A_mg).toString() + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin B6",  value:  (lastNutritionData?.summary?.micros?.vitamin_B6_mg).toString() + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin C",  value:  (lastNutritionData?.summary?.micros?.vitamin_C_mg).toString() + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin D",  value:  (lastNutritionData?.summary?.micros?.vitamin_D_mg).toString() + " mg"))
                    completion()
                }
            }
            else{
                client.getNutrition(startDate: DataView.startDate_, endDate: DataView.endDate_, toWebhook: false) { data in
                    let lastNutritionData = data?.data?.last
                    DataDisplay.dataToDisplay.append(DataField(name: "Calories",  value:  (lastNutritionData?.summary?.macros?.calories).toString() + " kcal"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Carbohydrates",  value:  (lastNutritionData?.summary?.macros?.carbohydrates_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Protein",  value:  (lastNutritionData?.summary?.macros?.protein_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Sugar",  value:  (lastNutritionData?.summary?.macros?.sugar_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Fat",  value:  (lastNutritionData?.summary?.macros?.fat_g).toString() + " g"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Cholesterol",  value:  (lastNutritionData?.summary?.macros?.cholesterol_mg).toString()  + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin A",  value:  (lastNutritionData?.summary?.micros?.vitamin_A_mg).toString() + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin B6",  value:  (lastNutritionData?.summary?.micros?.vitamin_B6_mg).toString() + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin C",  value:  (lastNutritionData?.summary?.micros?.vitamin_C_mg).toString() + " mg"))
                    DataDisplay.dataToDisplay.append(DataField(name: "Vitamin D",  value:  (lastNutritionData?.summary?.micros?.vitamin_D_mg).toString() + " mg"))
                    completion()
                }
            }
        default:
            return
        }

    }
}
