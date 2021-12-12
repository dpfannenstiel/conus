//
//  ContentView.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import SwiftUI

struct WolframCodeView: View {
    @Binding var code: WolframCode

    var body: some View {
        HStack {
            ForEach(code.bitArray.indices.reversed(), id: \.self) { bitIndex in
                RoundedRectangle(cornerRadius: 10.0)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(code.bitArray[bitIndex] == .on ? .gray : Color.primary)
                    .onTapGesture {
                        code = code.toggle(bitIndex)
                    }
            }
        }

    }
}

struct ContentView: View {
    @State private var wolframCode = WolframCode.rule30
    @State private var generationCount = 22
    var generations: [Generation] {
        try! readyZerothGeneration(of: generationCount)
            .generate(times: generationCount, with: wolframCode)
    }

    var body: some View {
        VStack {
            Text("\(wolframCode.code)")
            WolframCodeView(code: $wolframCode)
                .padding(.horizontal)
            VStack(spacing: 1.0) {
                ForEach(generations, id: \.self) { generation in
                    HStack(spacing: 1.0) {
                        ForEach(generation, id: \.self) { cell in
                            RoundedRectangle(cornerRadius: 2.0)
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(cell == .on ? .gray : Color.primary)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
