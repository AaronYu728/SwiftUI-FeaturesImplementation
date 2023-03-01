//
//  SlidingSelection.swift
//  SwiftUIImplementation
//
//  Created by BinYu on 1/3/2023.
//

import SwiftUI

//Use preferenceKey to implement a sliding selection

struct SlidingSelection: View {
    @State private var activeIdx = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 12)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2.0)
                .foregroundColor(.orange)
                .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                .offset(x: rects[activeIdx].minX, y: rects[activeIdx].minY)
                .animation(.easeInOut(duration: 0.35), value: activeIdx)
            VStack {
                HStack {
                    MonthView(activeIndex: $activeIdx, numberText: "Jan", index: 0)
                    MonthView(activeIndex: $activeIdx, numberText: "Feb", index: 1)
                    MonthView(activeIndex: $activeIdx, numberText: "Mar", index: 2)
                    MonthView(activeIndex: $activeIdx, numberText: "Apr", index: 3)
                }
                
                HStack {
                    MonthView(activeIndex: $activeIdx, numberText: "May", index: 4)
                    MonthView(activeIndex: $activeIdx, numberText: "June", index: 5)
                    MonthView(activeIndex: $activeIdx, numberText: "July", index: 6)
                    MonthView(activeIndex: $activeIdx, numberText: "Aug", index: 7)
                }
                
                HStack {
                    MonthView(activeIndex: $activeIdx, numberText: "Sep", index: 8)
                    MonthView(activeIndex: $activeIdx, numberText: "Oct", index: 9)
                    MonthView(activeIndex: $activeIdx, numberText: "Nov", index: 10)
                    MonthView(activeIndex: $activeIdx, numberText: "Dec", index: 11)
                }
                
            }
        }
        .coordinateSpace(name: "myZstack")
        .onPreferenceChange(MyTextPreferenceKey.self) { preferences in
            for eachPreference in preferences {
                self.rects[eachPreference.monthViewIdx] = eachPreference.monthViewrect
            }
        }
        
    }
}

struct MonthView: View {
    @Binding var activeIndex: Int
    let numberText: String
    let index: Int
    
    var body: some View {
        Text(numberText)
            .padding()
            .background(MyPreferenceVeiwSetter(idx: index))
            .onTapGesture {
                self.activeIndex = index
            }
//            .background(MothBorder(isShow: self.activeIndex == index))
    }
}

struct MothBorder: View {
    let isShow: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 2.0)
            .foregroundColor(isShow ? .red : .clear)
            .animation(.easeInOut(duration: 0.6) ,value: isShow)
    }
}

struct MyPreferenceVeiwSetter: View {
    let idx: Int
    var body: some View {
        GeometryReader { geometryProxy in
            Rectangle()
                .fill(.clear)
                .preference(
                    key: MyTextPreferenceKey.self,
                    value: [MyTextPreferenceData(monthViewIdx: idx, monthViewrect: geometryProxy.frame(in: .named("myZstack")))]
                )
        }
    }
}

struct MyTextPreferenceData: Equatable {
    let monthViewIdx: Int
    let monthViewrect: CGRect
}

struct MyTextPreferenceKey: PreferenceKey {
    typealias Value = [MyTextPreferenceData]
    static var defaultValue: [MyTextPreferenceData] = []
    
    static func reduce(value: inout [MyTextPreferenceData], nextValue: () -> [MyTextPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct PreferenceExplor_Previews: PreviewProvider {
    static var previews: some View {
        SlidingSelection()
    }
}
