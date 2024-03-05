//
//  frameView.swift
//  Kamera
//
//  Created by Lian Lin on 2024/3/4.
//

import SwiftUI



struct frameView: View {
    var image: CGImage?
    var canDoOutput: Bool?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            if canDoOutput! {
                Image(image, scale: 1.0, orientation: .up, label: self.label)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }else{
                Image(image, scale: 1.0, orientation: .up, label: self.label)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .blur(radius: 10.0)
//                    .grayscale(1.0)
            }
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
