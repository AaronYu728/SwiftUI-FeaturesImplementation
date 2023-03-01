//
//  HeadScrollTabBar.swift
//  SwiftUIImplementation
//
//  Created by BinYu on 1/3/2023.
//

import SwiftUI

//HeadScrollTabBar Usage
struct ScrollTabBarView: View {
    @Environment(\.presentationMode) var presentMode
    @State var index = 0
    let viewTitles = ["National", "World", "Local", "Lifestyle", "Travel", "Entertainment", "Technology", "Finance", "Sport", "More"]
    var body: some View {
        VStack {
            HeadScrollTabBar(titleArray: viewTitles, isScrollable: .constant(true), selectedIndex: $index)
                .background(.brown)
            TabView(selection: $index) {
                ForEach(0..<viewTitles.count, id: \.self) { pageId in
                    Text("Page \(pageId)")
                        .tag(pageId)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .navigationTitle("ScrollTabBarView")
            .navigationBarBackButtonHidden(true)
            .toolbar { // Customize the backward button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .frame(width: 45, height: 45, alignment: Alignment.leading)
                    }
                }
            }
        }
    }
}

//Use height alignment to impelement scrolling tabBar
struct HeadScrollTabBar: View {
    var titleArray: [String]
    @Binding var isScrollable: Bool
    private var axes: Axis.Set {
        return isScrollable ? .horizontal : []
    }
    @Binding var selectedIndex: Int
    var body: some View {
//        HStack{
            ScrollViewReader { proxyScrollview in
                ScrollView(axes, showsIndicators: false) {
                    VStack(alignment: .heightAlignment) {
                        HStack {
                            ForEach(titleArray.indices, id: \.self) { index in
                                if index == selectedIndex {
                                    CustomLabel(title: titleArray[index],
                                                index: index,
                                                selectedIndex: selectedIndex,
                                                normalColor: .primary,
                                                selectedColor: .blue)
                                        .transition(AnyTransition.identity)
                                        .alignmentGuide(.heightAlignment) { d in
                                            d[HorizontalAlignment.center]
                                        }
                                        .id(index)
                                }else {
                                    CustomLabel(title: titleArray[index],
                                                index: index,
                                                selectedIndex: selectedIndex,
                                                normalColor: .primary,
                                                selectedColor: .blue)
                                    .transition(AnyTransition.identity)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedIndex = index
                                            proxyScrollview.scrollTo(index, anchor: .center)
                                            
                                        }
                                    }
                                    .id(index)
                                }
                            }
                        }
                        //添加下划线
                        RoundedRectangle(cornerRadius: 3)
                            .frame(width: 20.0, height: 3.0)
                            .foregroundColor(.blue)
                            .transition(AnyTransition.identity)
                            .alignmentGuide(.heightAlignment) { d in
                                d[HorizontalAlignment.center]
                            }
                            .offset(x: 0, y: -10)
                    }
                }
                .onChange(of: selectedIndex){ newValue in
                    withAnimation() {
                        proxyScrollview.scrollTo(newValue, anchor: .center)
                    }
                }
                .animation(.easeInOut, value: true)
            }
        }
        
//    }
}

struct CustomLabel: View {
    let title: String
    let index: Int
    let selectedIndex: Int
    var normalColor: Color = .primary
    var selectedColor: Color = .blue
    var fontSize: CGFloat = 14.0
    
    var body: some View {
        Text(title)
            .font(.system(size: fontSize))
            .scaleEffect(selectedIndex == index ? 1.2 : 1.0)
            .foregroundColor(selectedIndex == index ? selectedColor : normalColor)
            .padding(.all, 10)
    }
}

//struct HeadScrollTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewTitles = ["National", "World", "Local", "Lifestyle", "Travel"]
//        HeadScrollTabBar(titleArray: viewTitles, isScrollable: .constant(true), selectedIndex:.constant(1))
//    }
//}
