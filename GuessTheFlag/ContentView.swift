//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by MacBook Pro on 18/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.red, .black]),
                           center: .center,
                           startRadius: 20, endRadius: 200
            )
        }
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
