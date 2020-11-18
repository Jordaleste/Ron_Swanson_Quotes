//
//  SwansonManager.swift
//  Ron_Swanson_Quotes
//
//  Created by Charles Eison on 11/17/20.
//

import Foundation

//API Docs: https://awesomeopensource.com/project/jamesseanwright/ron-swanson-quotes
//String Array to JSON: https://www.hackingwithswift.com/example-code/system/how-to-parse-json-using-jsonserialization

class SwansonManager: ObservableObject {
    
    @Published var quote = [String]()
    
    //This is called in our widget and below to send our quote back to our widget
    var completionHandler: (([String]) -> Void)?
    
    func fetchQuote() {
        
        if let url = URL(string: "https://ron-swanson-quotes.herokuapp.com/v2/quotes") {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    self.quote = [String(error!.localizedDescription)]
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    //typecasting our array of strings received from the API to an array of Strings. Because JSON expects a Key/Value pair, but this API only sends back an array of strings with no key, we use JSONSerialization so we can work with the response. Typically we use JSONDecoder to handle API calls, but here we can not.
                    
                    if let parsedQuotes = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                        
                        DispatchQueue.main.async {
                            
                            self.quote = parsedQuotes
                            
                            //now we can our completionhandler to give the quote back to our widget process.
                            self.completionHandler?(self.quote)
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }}
