//
//  ContentView.swift
//  Ron_Swanson_Quotes
//
//  Created by Charles Eison on 11/17/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var quote = SwansonManager()
    @State private var showingCredits = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    Image("ParksLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    
                    //Have to do .first instead of quote.quote[0]. .first returns optional, whereas [0] returns empty array, out of bounds, since network call has not happened yet.
                    Text("\(quote.quote.first ?? "Quote Incoming")")
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding(.bottom, 4)
                        
                    Button("Gimme another!") {
                        quote.fetchQuote()
                    }
                    .font(.footnote)
                    
                    Text("""
                        Parks and Recreation (also known as Parks and Rec) is an American political satire mockumentary sitcom television series created by Greg Daniels and Michael Schur. The series aired on NBC from April 9, 2009, to February 24, 2015, for 125 episodes, over seven seasons.

                        Ronald Ulysses Swanson is a fictional character portrayed by Nick Offerman from the situation comedy television series Parks and Recreation on NBC, created by Greg Daniels and Michael Schur. In the series, Ron is the director of the Parks and Recreation department of fictional town of Pawnee, Indiana, and the immediate superior of series protagonist Leslie Knope (Amy Poehler) until Knope's election to the Pawnee City Council at the end of Season 4. In demeanor, political philosophy and work ethic, Knope and Swanson are polar opposites: where Knope is sunny and outgoing, decidedly tolerant and constantly working, Swanson is distant, and as a staunch libertarian, is a strong advocate for small government—stating his belief that government should be privatized—and therefore believes that the parks department should not even exist. He says he is there to rot the beast from the inside.

                        Ron, who has an extremely deadpan and stereotypical masculine personality, actively works to make city hall less effective and despises interacting with the public. He loves meat, woodworking, hunting, whisky, breakfast foods, nautical literature, and sex. He hates and fears his ex-wives, both named Tammy, one of whom is played by Offerman's real-life wife, Megan Mullally. Ron claims not to be interested in the personal lives of those around him but actually cares a great deal about his colleagues and has a particularly strong respect for Leslie.
                        """)
                        .padding()
                }
            }
            .onAppear{quote.fetchQuote()}
            .navigationBarItems(trailing: Button("Credits") { showingCredits.toggle()})
            .sheet(isPresented: $showingCredits, content: {
                CreditsView()
            })
        }
        // Need this to look right on iPad / Mac
        // Without this, navigation views default to a master/detail style
        // Also need to program a back button for sheets on Mac
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
