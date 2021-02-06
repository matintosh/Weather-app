//
//  ContentView.swift
//  Weather-App
//
//  Created by Matias Martinez on 6/2/21.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct ContentView: View {
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView( isNight: $isNight,
                            topColor: .blue,
                            bottomColor: Color("lightBlue"))
                .transition(.slide)
            VStack {
                CityTextView(city: "Montevideo, UY")
                
                MainWeatherStatusView(isNight: $isNight,
                                      temperature: 27)
                    .transition(.moveAndFade)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 50) {
                        WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 27)
                        WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.rain.fill", temperature: 21)
                        WeatherDayView(dayOfWeek: "WED", imageName: "cloud.sun.bolt.fill", temperature: 24)
                        WeatherDayView(dayOfWeek: "THU", imageName: "sun.max.fill", temperature: 78)
                        WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 22)
                        WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: 24)
                        WeatherDayView(dayOfWeek: "SUN", imageName: "sun.max.fill", temperature: 32)
                        
                    }
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                }
                    
                Spacer()
                
                Button {
                    withAnimation{
                        isNight.toggle()
                    }
                    
                } label: {
                    WeatherButton(label: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight:.regular))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: isNight ? Gradient(colors: [.black, .gray]) : Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var city: String
    
    var body: some View {
        Text(city)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    @Binding var isNight: Bool
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 12) {
            isNight ? Image(systemName:  "moon.stars.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .transition(.move(edge: .bottom))
                .frame(width: 180, height: 180)
                : Image(systemName:  "cloud.sun.rain.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.slide)
                    .frame(width: 180, height: 180)
                
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

