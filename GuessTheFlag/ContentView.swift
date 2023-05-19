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
            VStack {
                Button("Button 1") { }
                    .buttonStyle(.bordered)
                Button("Button 2", role: .destructive) { }
                    .buttonStyle(.bordered)
                Button("Button1") { }
                    .buttonStyle(.borderedProminent)
                    .tint(.teal)
                Button("Button1", role: .destructive) { }
                    .buttonStyle(.borderedProminent)
                Button {
                    print("Tap this button")
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
