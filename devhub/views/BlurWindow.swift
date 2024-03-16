//
//  BlurWindow.swift
//  devhub
//
//  Created by Chanakan Mungtin on 16/3/2567 BE.
//

import SwiftUI

struct BlurWindow: NSViewRepresentable {
    func makeNSView(context: Context) -> some NSView {
       let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}

#Preview {
    BlurWindow()
}
