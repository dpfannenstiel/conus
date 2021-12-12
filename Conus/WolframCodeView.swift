//
//  WolframCodeView.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/12/21.
//

import SwiftUI

/// A view for editing a `WolframCode` on a bitwise basis
struct WolframCodeView: View {
    @Binding var code: WolframCode

    var body: some View {
        HStack {
            ForEach(code.bitArray.indices.reversed(), id: \.self) { bitIndex in
                RoundedRectangle(cornerRadius: 10.0)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(code.bitArray[bitIndex] == .on ? Color( "BitOn") : Color("BitOff"))
                    .onTapGesture {
                        code = code.toggle(bitIndex)
                    }
            }
        }
    }
}


struct WolframCodeView_Previews: PreviewProvider {
    static var previews: some View {
        WolframCodeView(code: .constant(WolframCode.rule30))
    }
}
