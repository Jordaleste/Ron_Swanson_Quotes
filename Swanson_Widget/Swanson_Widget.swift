//
//  Swanson_Widget.swift
//  Swanson_Widget
//
//  Created by Charles Eison on 11/17/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: "Stand by for a Ron Swanson-ism")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        //Be sure to add Widget Targets to SwansonManager
        let swansonManager = SwansonManager()
        swansonManager.completionHandler = { quotes in
            let quotes = quotes
            guard let quoteToDisplay = quotes.first else { return }
            
            let entry = SimpleEntry(date: Date(), quote: quoteToDisplay)
            completion(entry)
        }
        swansonManager.fetchQuote()
        
        
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let swansonManager = SwansonManager()
        swansonManager.completionHandler = { quotes in
            
            guard let quoteToDisplay = quotes.first else { return }
            
            let entry = SimpleEntry(date: Date(), quote: quoteToDisplay)
            let timeToRefresh = Date().addingTimeInterval(60*60*1)
            let timeLine = Timeline(entries: [entry], policy: .after(timeToRefresh))
            completion(timeLine)
        }
        swansonManager.fetchQuote()
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: String
}

struct Swanson_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .bottom, endPoint: .top)
            VStack {
                HStack {
                    Text("Swanson-ism")
                        .foregroundColor(.red)
                    Spacer()
                    Text("☠️")
                }
                Spacer()
                Text(entry.quote)
                    .foregroundColor(.red)
                Spacer()
            }
            .padding()
        }
    }
}

@main
struct Swanson_Widget: Widget {
    let kind: String = "Swanson_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Swanson_WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Ron Swanson-isms")
        .description("Random Ron Swanson quotes displayed right on your home screen")
    }
}

struct Swanson_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Swanson_WidgetEntryView(entry: SimpleEntry(date: Date(), quote: "Test Swanson Quote"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
