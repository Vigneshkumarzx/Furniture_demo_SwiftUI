//
//  CustomTabBarView.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding  var currentTab: Tab
    @State var currentXValue: CGFloat = 0
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(tab: tab)
                    .overlay {
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.gray)
                            .offset(y: currentTab == tab ? 15 : 100)
                    }
            }
        }
        .padding(.top)
        .padding(.bottom, getdafeArea().bottom == 0 ? 15 : 10)
        .background {
            Color.gray.opacity(0.08)
                .shadow(color: Color("Black").opacity(0.08), radius: 5, x: 0, y: -5)
                .clipShape(BottomCurve(currentXValue: currentXValue))
                .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        GeometryReader { proxy in
            
            Button(action: {
                withAnimation(.easeInOut) {
                    currentTab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            }, label: {
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(currentTab == tab ? .white : .gray.opacity(0.8))
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            if currentTab == tab {
                                Circle()
                                    .fill(Color.orange)
                                    .shadow(color: Color("Black").opacity(0.1), radius: 5, x: 8, y: 5)
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
    case Home = "Home"
    case Cart = "Cart"
    case Fav = "Favorite"
    case Profile = "Profile"
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
