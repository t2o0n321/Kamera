//
//  frameView.swift
//  Kamera
//
//  Created by Lian Lin on 2024/3/4.
//

import SwiftUI

struct frameView: View {
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .up, label: self.label)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }else{
            Color.black
        }
    }
    
}

struct frameView_Previews: PreviewProvider{
    static var previews: some View {
        frameView()
    }
}
