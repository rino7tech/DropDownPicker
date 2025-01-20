//
//  ContentView.swift
//  DropDownPicker
//
//  Created by 伊藤璃乃 on 2025/01/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: String?
    private let optionsArray = ["Youtube", "Instagram", "X", "Snapchat", "Tiktok"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                DropDownView(hint: "Select", options: optionsArray, selection: $selection)
            }
        }
    }
}


#Preview {
    ContentView()
}
