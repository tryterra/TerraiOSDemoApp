//
//  DataRequestView.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import SwiftUI
import TerraiOS


struct DatePickerView: View{
    @Binding var showPicker: Bool
    @Binding var shownDate: Date
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(spacing: 0){
                Spacer()
                DatePicker("", selection: $shownDate, displayedComponents: [.date]).datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(width: geometry.size.width ,height: 212, alignment: .center)
                    .background(Color.white)
                ZStack{
                    Rectangle()
                        .fill(Color.black)
                    VStack{
                        Text("Done")
                            .font(Font.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(Color.white)
                            .padding(.top, 12)
                        Spacer()
                    }
                }.frame(width: geometry.size.width , height: 60)
                .onTapGesture {
                    showPicker.toggle()
                }
            }
        }.ignoresSafeArea(.all)
    }
}

struct DataRequestView : View {
    
    private var userId: String?
    private var dataType: String
    private var resource: String
    
    @Binding var path: [String]
    
    @State var showStartDatePicker: Bool = false
    @State var showEndDatePicker: Bool = false
    
    @State var requestData: Bool = false
    
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    public static var startDate_: Date = Date()
    public static var endDate_: Date = Date()
    
    init(_ userId: String?, _ dataType: String, _ resource: String, _ path: Binding<[String]>) {
        self.userId = userId
        self.resource = resource
        self.dataType = dataType
        self._path = path
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ZStack{
                    HStack{
                        BackButton(path: $path).padding(.leading, 10)
                        Spacer()
                    }
                    Text("Request Data").font(Font.custom("Poppins-Bold", size: 16))
                }.padding(.top, 10)
                    .frame(width: geometry.size.width, height: 24, alignment: .center)
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.blockShadow, radius:6, x: 0, y: 2)
                    VStack(spacing: 30){
                        HStack{
                            Text("Choose Date")
                                .font(Font.custom("Poppins-Bold", size: 24))
                                .padding([.leading, .top], 24)
                            Spacer()
                        }
                        ZStack{
                            Rectangle()
                                .stroke(Color.init(.sRGB, red: 0.92, green: 0.92, blue: 0.92, opacity: 1), lineWidth: 1)
                                .cornerRadius(8)
                            VStack{
                                HStack{
                                    Text("From: ").font(Font.custom("Poppins-Regular", size: 14)).padding(.leading, 12)
                                    Spacer()
                                }.padding(.top, 8)
                                HStack{
                                    Text(ISO8601DateFormatter.string(from: startDate, timeZone: TimeZone.current, formatOptions: [.withDay, .withYear, .withMonth, .withDashSeparatorInDate])).font(Font.custom("Poppins-Regular", size: 16)).padding(.leading, 12)
                                    Spacer()
                                    Image("calendar").frame(width: 18, height: 19.5).padding(.trailing, 12)
                                        .onTapGesture {
                                            showStartDatePicker.toggle()
                                        }
                                }.padding([.bottom, .top], 8)
                            }.frame(alignment: .center)
                        }.frame(width: geometry.size.width * 0.8, height: 50, alignment: .center).padding(.top, 20)
                        ZStack{
                            Rectangle()
                                .stroke(Color.init(.sRGB, red: 0.92, green: 0.92, blue: 0.92, opacity: 1), lineWidth: 1)
                                .cornerRadius(8)
                            VStack{
                                HStack{
                                    Text("To: ").font(Font.custom("Poppins-Regular", size: 14)).padding(.leading, 12)
                                    Spacer()
                                }
                                .padding(.top, 8)
                                HStack{
                                    Text(ISO8601DateFormatter.string(from: endDate, timeZone: TimeZone.current, formatOptions: [.withDay, .withYear, .withMonth, .withDashSeparatorInDate])).font(Font.custom("Poppins-Regular", size: 16)).padding(.leading, 12)
                                    Spacer()
                                    Image("calendar").frame(width: 18, height: 19.5).padding(.trailing, 12)
                                        .onTapGesture {
                                            showEndDatePicker.toggle()
                                        }
                                }.padding([.bottom, .top], 8)
                            }.frame(alignment: .center)
                        }.frame(width: geometry.size.width * 0.8, height: 50, alignment: .center).padding(.top, 16)
                        Spacer()
                        Text("The data you’re requesting will be displayed for the date range you select here.")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width * 0.7, height: 109, alignment: .center)
                            .background(
                                Rectangle()
                                    .fill(Color.init(.sRGB, red: 240/255, green: 246/255, blue:255/255, opacity: 1))
                                    .cornerRadius(8)
                                    .frame(width: geometry.size.width * 0.8, height: 109, alignment: .center)
                            ).padding(.bottom, 20)
                    }.frame(alignment: .center)
                }.padding(.top, 40)
                    .frame(width: geometry.size.width*9/10, height: 500, alignment: .center)
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .ignoresSafeArea(.all)
                        .frame(height: 120)
                    HStack{
                        Text("Cancel Request")
                            .font(Font.custom("Poppins-SemiBold", size: 14))
                            .padding(.leading, 16)
                            .onTapGesture {
                                let _ = path.popLast()
                            }
                        Spacer()
                        Button(action: {
                            path.append("dataView")
                        }, label: {
                            Text("Continue")
                                .font(Font.custom("Poppins-SemiBold", size: 14))
                                .foregroundColor(Color.white)
                                .background(
                                    Rectangle()
                                        .fill(Color.darkBackground)
                                        .cornerRadius(22)
                                        .frame(width: 122, height: 37)
                                )
                        }).padding(.trailing, 40)
                    }
                }.frame(width: geometry.size.width, alignment: .center)
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }.navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showStartDatePicker, content: {
            DatePickerView(showPicker: $showStartDatePicker, shownDate: $startDate)
                .background(RemoveBackgroundColor())
                .onDisappear{
                    DataRequestView.startDate_ = startDate
                }
        })
        .sheet(isPresented: $showEndDatePicker, content: {
            DatePickerView(showPicker: $showEndDatePicker, shownDate: $endDate)
                .background(RemoveBackgroundColor())
                .onDisappear{
                    DataRequestView.endDate_ = endDate
                }
        })
        .background(Color.appBackground, ignoresSafeAreaEdges: .vertical)
    }
}
