//
//  EditView.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/12/21.
//

import SwiftUI

/// A view to edit the settings of the presentation
struct EditView: View {
    /// The current WolframCode to use
    @Binding var code: WolframCode
    /// The current number of generations to evaluate
    @Binding var generations: Double

    var body: some View {
        VStack {
            Text("Rule \(code.code)")
                .font(.title3)
            WolframCodeView(code: $code)
                .padding(.horizontal)
            Form {
                Section(header: Text("Restore Defaults")) {
                    Text("Restore")
                        .onTapGesture {
                            code = .rule30
                            generations = GenerationDefaults.default
                        }
                }
                Section(header: Text("Common Rules")) {
                    ForEach(WolframCode.RulesModels.ruleNames, id:\.self) { string in
                        Text(string)
                            .onTapGesture {
                                code = WolframCode.RulesModels.rules[string]!
                            }
                    }
                }
                Section(header: Text("Generations")) {
                    HStack {
                        Text("\(generations, specifier: "%.0f")")
                        Slider(value: $generations, in: GenerationDefaults.min...GenerationDefaults.max, step: 1.0)
                            .tint(Color("BitOff"))
                    }
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(
            code: .constant(WolframCode.rule30),
            generations: .constant(GenerationDefaults.default)
        )
    }
}
