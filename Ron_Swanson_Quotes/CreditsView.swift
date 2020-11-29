//
//  CreditsView.swift
//  Ron_Swanson_Quotes
//
//  Created by Charles Eison on 11/29/20.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                //Spacer()
                Text("Special thanks to James Wright, who provided the repository of Ron Swanson Quotes through his API.")
                    .padding(.vertical)
                
                Text("Q: James, why did you make this API?")
                
                Text("A: \(Text("Because Ron Swanson is a hero.").italic())")
                Spacer()
                
                    
//                Spacer()
                    //.font(.system(size: 30))
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    //foregroundColor and background set to account for dark mode
//                    .foregroundColor(.primary)
//                    .background(Color.gray)
//                    .cornerRadius(8)
                Link("Parks and Rec info sourced from Wikipedia.", destination: URL(string: "https://en.wikipedia.org/wiki/Ron_Swanson")!)
                    .padding(.vertical)
                Link("Quotes sourced from James Wright's API", destination: URL(string: "https://awesomeopensource.com/project/jamesseanwright/ron-swanson-quotes")!)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    //foregroundColor and background set to account for dark mode
//                    //.foregroundColor(.primary)
//                    .background(Color.gray)
//                    .cornerRadius(8)
            }
            .navigationBarItems(leading: Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")
            })
            .padding()
            .navigationBarTitle("Credits")
        }
        
    }
    
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
