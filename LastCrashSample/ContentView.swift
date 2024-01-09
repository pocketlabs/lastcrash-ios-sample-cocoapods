//
//  ContentView.swift
//  LastCrashSample
//
//  Created by Kyle Shank on 1/8/24.
//

import SwiftUI
import LastCrash

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Test Crash") {
                let s : String? = nil
                print(" " + s!)
            }
            Button("Pause Recording") {
                LastCrash.pause()
            }
            Button("Unpause Recording") {
                LastCrash.unpause()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
