//
//  ContentView.swift
//  Analog Clock
//
//  Created by Юрий Станиславский on 18.09.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var isDark = false
    
    var body: some View {
        NavigationView {
            ClockView(isDark: $isDark)
                .navigationBarHidden(true)
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
