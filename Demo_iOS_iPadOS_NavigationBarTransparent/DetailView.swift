//
//  DetailView.swift
//  Demo_iOS_iPadOS_NavigationBarTransparent
//
//  Created by 荒木辰造 on R 5/03/16.
//

import SwiftUI

struct DetailView: View {
    let selectedIndex: Int
    let lists: [[Int]]

    var body: some View {
        ZStack {
            ForEach(0..<count, id: \.self) { index in
                if index >= lists.startIndex, index <= lists.endIndex, !lists[index].isEmpty {
                    List(lists[index], id: \.self) { index in
                        Text(index.description)
                    }
                    .opacity(index == selectedIndex ? 1 : 0)
                }
            }
        }
        .navigationTitle("List \(selectedIndex)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(selectedIndex: 0, lists: [[1], [2], [3]])
        }
    }
}
