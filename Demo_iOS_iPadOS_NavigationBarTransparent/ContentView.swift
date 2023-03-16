//
//  ContentView.swift
//  Demo_iOS_iPadOS_NavigationBarTransparent
//
//  Created by 荒木辰造 on R 5/03/16.
//

import SwiftUI

// Hard-coding
let count = 3

struct ContentView: View {
    @State private var selectedIndex = 0
    @State private var lists = [[Int]](repeating: [], count: count)
    @State private var hasGeneratedListOnce = [Bool](repeating: false, count: count)

    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $selectedIndex) {
                    ForEach(0..<count, id: \.self) { index in
                        Text(index.description).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                ForEach(0..<count, id: \.self) { index in
                    GeneratorCell(
                        tag: index,
                        list: $lists[index],
                        hasGeneratedOnce: $hasGeneratedListOnce[index]
                    )
                }

                NavigationLink(
                    destination: { DetailView(selectedIndex: selectedIndex, lists: lists) },
                    label: { Text("Next") }
                )
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            .navigationTitle("Demo")
        }
    }
}

private struct GeneratorCell: View {
    let tag: Int
    @Binding var list: [Int]
    @Binding var hasGeneratedOnce: Bool

    var body: some View {
        HStack {
            Button("Generate List \(tag)") {
                list = .init(0...10)
                hasGeneratedOnce = true
            }

            Image(systemName: "checkmark")
                .foregroundColor(.green)
                .opacity(hasGeneratedOnce ? 1 : 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
