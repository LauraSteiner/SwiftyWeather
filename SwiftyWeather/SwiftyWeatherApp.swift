//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/11/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftyWeatherApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Preference.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            WeatherView()
        }
        .modelContainer(sharedModelContainer)
    }
}
