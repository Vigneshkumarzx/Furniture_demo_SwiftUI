//
//  MaterialEffect.swift
//  Furniture_demo_SwiftUI
//
//  Created by vignesh kumar c on 30/10/23.
//

import SwiftUI

struct MaterialEffect: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
 
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

