//
//  ContentView.swift
//  Ron_Swanson_Quotes
//
//  Created by Charles Eison on 11/17/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var quote = SwansonManager()
    
    var body: some View {
        
        NavigationView {
            Text(quote.quote[0])
                .padding()
        }
        .onAppear{quote.fetchQuote()}    
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
