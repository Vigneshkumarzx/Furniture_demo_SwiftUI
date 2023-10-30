//
//  CustomTabBarView.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding private var currentTab: Tab
    @State private var currentXValue: CGFloat = 0
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(tab: tab)
            }
        }
        .padding(.vertical)
        .padding(.bottom, getdafeArea().bottom == 0 ? 10 : getdafeArea().bottom - 10)
        .background(Color.white)
        .shadow(color: Color("Black").opacity(0.08), radius: 5, x: 0, y: -5)
        .clipShape(BottomCurve(currentXValue: currentXValue))
        .ignoresSafeArea(.container, edges: .bottom)
        
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
                Image(tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            if currentTab == tab {
                                Circle()
                                    .fill(Color("Orange"))
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
//
//#Preview {
//    CustomTabBarView()
//}

enum Tab: String, CaseIterable {
    case Home = "home"
    case Search = "cart"
    case Notification = "star"
    case Account = "search"
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
