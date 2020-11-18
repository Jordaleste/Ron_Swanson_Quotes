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
            //Have to do .first instead of quote.quote[0]. .first returns optional, whereas [0] returns empty array, out of bounds, since network call has not happened yet.
            Text(quote.quote.first ?? "Quote Incoming...")
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
