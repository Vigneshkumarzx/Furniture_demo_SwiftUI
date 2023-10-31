//
//  Home.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var appModel: AppViewModel
    var animation: Namespace.ID
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("VK Furniture")
                        .font(.title.bold())
                    Text("Perfect Choice!")
                        .font(.callout)
                }
                .foregroundColor(Color("Black"))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                HStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Image("Search")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color("Black"))
                        TextField("Search", text: .constant(""))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 25)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray.opacity(0.08))
                            .frame(height: 50)
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Image("filter")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color("Black"))
                            .frame(width: 25, height: 25)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.gray.opacity(0.08))
                            }
                    })
                    
                }
                
                HStack(spacing: 0) {
                    ForEach(["All", "Chair","Table", "Lamp", "Floor"], id:\.self) { menu in
                        
                        Text(menu)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(appModel.currentMenu == menu ? .white : .black)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background {
                                if appModel.currentMenu == menu {
                                    Capsule()
                                        .fill(Color("Black"))
                                        .shadow(color: Color("Black").opacity(0.1), radius: 5, x: 5, y: 5)
                                        .matchedGeometryEffect(id: "Menu", in: animation)
                                }
                            }
                        
                    }
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
    }
}

#Preview {
    ContentView()
}
