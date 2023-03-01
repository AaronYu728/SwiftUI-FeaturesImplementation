//
//  HomeLsitView.swift
//  SwiftUIImplementation
//
//  Created by BinYu on 1/3/2023.
//

import SwiftUI

struct HomeLsitView: View {
    var featureViewList = [LinkeView(linkName: "Sliding selection of months", linkView: AnyView(SlidingSelection())),
                           LinkeView(linkName: "Head scrolling tabBar", linkView: AnyView(ScrollTabBarView()))]
    var body: some View {
        NavigationView{
            List(featureViewList){ featureView in
                NavigationLink(destination: featureView.linkView) {
                    HStack{
                        Text(featureView.linkName)
                    }
                }
            }
            .navigationTitle("Features Exploring")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeLsitView()
    }
}
