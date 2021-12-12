//
//  ContentView.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import SwiftUI

/// The introductory content view
struct ContentView: View {
    @Environment(\.openURL) var openURL

    /// The current `WolframCode`, defaults to `rule30`
    @State private var wolframCode = WolframCode.rule30
    /// The number of generations to evaluate
    @State private var generationCount = GenerationDefaults.default
    /// The state to use while editing the WolframCode
    @State private var updateCode = WolframCode.rule30
    /// The state to use while editing the generation count
    @State private var updateCount = GenerationDefaults.default
    /// True iff showing the edit page
    @State private var showingEdit = false
    /// GenerationCount as Int
    var count: Int { Int(generationCount) }
    /// Produces the generations as an array
    var generations: [Generation] {
        try! readyZerothGeneration(of: count)
            .generate(times: count, with: wolframCode)
    }

    var body: some View {
        NavigationView {
            VStack {
                WolframCodeView(code: $wolframCode)
                    .padding(.horizontal)
                ScrollView([.horizontal]) {
                        VStack(spacing: 1.0) {
                            ForEach(generations, id: \.self) { generation in
                                HStack(spacing: 1.0) {
                                    ForEach(generation, id: \.self) { cell in
                                        RoundedRectangle(cornerRadius: 2.0)
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .foregroundColor(cell == .on ? Color( "BitOn") : Color("BitOff"))
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Rule \(wolframCode.code)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: showEdit) { Image(systemName: "pencil.circle")},
                trailing: Button(action: showAbout) { Image(systemName: "info.circle")}
            )
            .sheet(isPresented: $showingEdit) {
                NavigationView {
                    EditView(code: $updateCode, generations: $updateCount)
                        .navigationBarItems(
                            leading: Button("Dismiss") { showingEdit = false},
                            trailing: Button("Update") {
                                wolframCode = updateCode
                                generationCount = updateCount
                                showingEdit = false
                        })
                }
            }
            .tint(Color("BitOn"))
        }
    }

    /// Show the edit field.
    /// Copies the current `WolframCode` and generationCount into
    /// the update states so that the user may dismiss non-destructively.
    func showEdit() {
        updateCode = wolframCode
        updateCount = generationCount
        showingEdit = true
    }

    /// Encapsulates showing information about Rule 30.
    /// TODO: Add a in process web viewer
    func showAbout() {
        openURL(URL(string: "https://en.m.wikipedia.org/wiki/Rule_30")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
