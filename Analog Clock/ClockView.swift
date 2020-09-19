//
//  ClockView.swift
//  Analog Clock
//
//  Created by Юрий Станиславский on 18.09.2020.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var isDark: Bool
    @State private var currentTime = Time(min: 0, sec: 0, hour: 0)
    @State private var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer(minLength: 0)
                Button(action: {
                    isDark.toggle()
                }, label: {
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        .background(Color.primary)
                        .clipShape(Circle())
                })
            }
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                Circle()
                    .fill(Color("Color").opacity(0.1))
                
                // timestamps
                ForEach(0..<60, id: \.self) { i in
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (width - 110) / 2)
                        .rotationEffect(.init(degrees: Double(i) * 6))
                }
                
                // second hand
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (width - 180) / 2)
                    .offset(y: -(width - 180) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
                
                // minute hand
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4, height: (width - 200) / 2)
                    .offset(y: -(width - 200) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
                
                // hour hand
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4.5, height: (width - 240) / 2)
                    .offset(y: -(width - 240) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.hour + (currentTime.min / 60)) * 30))
                
                // center
                Circle()
                    .fill(Color.primary)
                    .frame(width: 10, height: 10)
                
            }
            .frame(width: width - 80, height: width - 80)
            
            // get locale region name
            Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 35)
            
            Text(gettime())
                .font(.system(size: 45))
                .fontWeight(.heavy)
                .padding(.top, 10)
            
            Spacer(minLength: 0)
        }
        .onAppear(perform: {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
        })
        .onReceive(receiver, perform: { _ in
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
        })
    }
    
    func gettime() -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        
        return format.string(from: Date())
    }
}

// calculator

struct Time {
    var min: Int
    var sec: Int
    var hour: Int
}
