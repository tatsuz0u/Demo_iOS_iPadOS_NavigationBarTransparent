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
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    @State private var hasGeneratedListOnce = [Bool](repeating: false, count: count)

    var generatorCells: some View {
        ForEach(0..<count, id: \.self) { index in
            GeneratorCell(
                tag: index,
                list: $lists[index],
                hasGeneratedOnce: $hasGeneratedListOnce[index]
            )
        }
    }

    var phoneLayout: some View {
        VStack {
            Picker("", selection: $selectedIndex) {
                ForEach(0..<count, id: \.self) { index in
                    Text(index.description).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            generatorCells

            NavigationLink(
                destination: { DetailView(selectedIndex: selectedIndex, lists: lists) },
                label: { Text("Next") }
            )
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
        .navigationTitle("Demo")
    }

    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            NavigationStack {
                phoneLayout
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView(
                columnVisibility: $columnVisibility,
                sidebar: { generatorCells.navigationTitle("Demo") },
                content: {
                    List(selection: $selectedIndex.asOptional) {
                        ForEach(0..<count, id: \.self) { index in
                            NavigationLink(index.description, value: index)
                        }
                    }
                },
                detail: { DetailView(selectedIndex: selectedIndex, lists: lists) }
            )
        }
    }
}

extension Binding {
    var asOptional: Binding<Value?> {
        .init(get: { wrappedValue }, set: { if let value = $0 { wrappedValue = value } })
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
