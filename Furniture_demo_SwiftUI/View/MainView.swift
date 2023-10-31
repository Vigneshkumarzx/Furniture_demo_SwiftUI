//
//  MainView.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var appModel: AppViewModel = .init()
    @Namespace var animation
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        TabView(selection: $appModel.currentTab) {
          Home(animation: animation)
                .environmentObject(appModel)
                .tag(Tab.Home)
                .setubTabBar()
            Text("Cart")
                .tag(Tab.Cart)
                .setubTabBar()
            Text("Favorite")
                .tag(Tab.Fav)
                .setubTabBar()
            Text("Profile")
                .tag(Tab.Profile)
                .setubTabBar()
        }
        .overlay(alignment: .bottom) {
            CustomTabBarView(currentTab: $appModel.currentTab, animation: animation)
        }
    }
}

#Preview {
    MainView()
}

extension View {
    @ViewBuilder
    func setubTabBar() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color("BG")
                    .ignoresSafeArea()
            }
    }
}
