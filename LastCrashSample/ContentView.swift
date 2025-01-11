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
            Text("hello_world")
            Button("test_crash") {
                let s : String? = nil
                print(" " + s!)
            }
            Button("pause_recording") {
                LastCrash.pause()
            }
            Button("unpause_recording") {
                LastCrash.unpause()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
