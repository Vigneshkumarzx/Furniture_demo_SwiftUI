//
//  CustomTabBarView.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @State private var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State private var currentXValue: CGFloat = 0
    @Namespace var animation
    
    var body: some View {
        TabView(selection: $currentTab) {
            Text("Home")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color("Color2"))
                .tag(Tab.Home)
            Text("Search")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               // .background(Color("Color2"))
                .background(Color.black)
                .tag(Tab.Search)
            Text("Notification")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               // .background(Color("Color2"))
                .tag(Tab.Notification)
            Text("Settings")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
              //  .background(Color("Color2"))
                .tag(Tab.Account)
        }
        .overlay(
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                }
            }
            .padding(.vertical)
            .padding(.bottom, getdafeArea().bottom == 0 ? 10 : getdafeArea().bottom - 10)
            .background(
                MaterialEffect(style: .systemUltraThinMaterialDark)
                    .clipShape(BottomCurve(currentXValue: currentXValue))
            )
            ,alignment: .bottom)
        .ignoresSafeArea(.all, edges: .bottom)
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        GeometryReader { proxy in
            
            Button(action: {
                withAnimation(.spring()) {
                    currentTab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            }, label: {
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            if currentTab == tab {
                                MaterialEffect(style: .systemMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            })
            .onAppear {
                
                if tab == Tab.allCases.first && currentXValue == 0 {
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
           
        }
        .frame(height: 30)
    }
}

#Preview {
    CustomTabBarView()
}

enum Tab: String, CaseIterable {
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Notification = "bell.fill"
    case Account = "person.crop.circle.fill"
}


extension View {
    
    func getdafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return.zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
