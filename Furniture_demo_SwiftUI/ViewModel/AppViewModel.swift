//
//  AppViewModel.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

class AppViewModel: ObservableObject {

    @Published var currentTab: Tab = .Home
    @Published var currentMenu: String = "All"
}
