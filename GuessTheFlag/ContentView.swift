//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by MacBook Pro on 18/5/23.
//

import SwiftUI

struct FlagImage: View {
    var countries: [String]
    var number: Int
    
    var body: some View {
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct LargeWhiteFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func largeWhiteTitle() -> some View {
        modifier(LargeWhiteFont())
    }
}


struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2 )
    @State private var userScore = 0
    @State private var counter = 1
    
    @State private var selectedNumber = 0
    @State private var animationAmount = 0.0
    @State private var isOpaque = false
    @State private var isWrong = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.1, blue: 0.1), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.60, blue: 0.40), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .largeWhiteTitle()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countries: countries, number: number)
                                .rotation3DEffect(.degrees(shouldRotate(number) ?  animationAmount : 0.0),
                                                  axis: (x: 0.0, y: 1.0, z: 0.0))
                                .opacity(self.isOpaque && self.correctAnswer != number ? 0.25 : 1.0)
                                
                        }
                        .rotation3DEffect(.degrees(self.isWrong && self.selectedNumber == number ? 90.0 : 0.0), axis: (x: 0, y: 0, z: 1))
                        
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Socre: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if counter != 10 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Reset", action: resetValues)
            }
        } message: {
            if counter != 10 {
                Text("Your score is \(userScore)")
            } else {
                Text("Your final score is \(userScore). tap the reset button")
            }
        }
        
    }
    
    func shouldRotate(_ number: Int) -> Bool {
        var rotate = false
        if number == correctAnswer {
            rotate = true
        }
        return rotate
    }
    
    func resetValues() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        counter = 1
        userScore = 0
    }
    
    func flagTapped(_ number: Int) {
        self.selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct! The flag is \(countries[number])"
            userScore += 10
            self.isOpaque = true
            withAnimation {
                self.animationAmount += 360
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number]) 😕"
            isWrong = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showingScore = true

        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        counter += 1
        self.isOpaque = false
        isWrong = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
