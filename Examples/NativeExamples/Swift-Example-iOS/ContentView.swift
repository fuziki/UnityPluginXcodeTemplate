//
//  ContentView.swift
//  Swift-Example-iOS
//
//  Created by fuziki on 2021/05/12.
//

import SwiftUI
import SwiftPmPlugin

struct ContentView: View {
    var body: some View {
        Text("number: \(swiftPmPlugin_toNumber("20"))")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
