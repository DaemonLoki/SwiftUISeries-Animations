//
//  TwitterLikeView.swift
//  SwiftUISeriesAnimations
//
//  Created by Stefan Blos on 23.05.22.
//

import SwiftUI

struct TwitterLikeView: View {
    
    @State private var scale: CGFloat = 0.0
    @State private var grayOpacity = 1.0
    @State private var active = false
    
    let speed = 0.3
    var stiffness = 250.0
    var damping = 15.0
    var mass = 0.6
    
    let dampingFactor = 3.0
    let speedFactor = 0.1
    let opacityFactor = 0.1
    let baseOpacity = 0.5
    
    
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
                .opacity(grayOpacity)
                .animation(.spring().speed(speed), value: grayOpacity)
            
            ForEach(0...5, id: \.self) {
                createImage(index: $0)
            }
        }
        .onTapGesture {
            scale = active ? 0 : 1
            grayOpacity = active ? 1 : 0
            active.toggle()
        }
    }
    
    @ViewBuilder private func createImage(index: Int) -> some View {
        Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .hueRotation(.degrees(.random(in: 0...360)))
            .opacity(calculateOpacity(index))
            .foregroundColor(.blue)
            .scaleEffect(scale)
            .animation(
                .interpolatingSpring(
                    mass: mass,
                    stiffness: stiffness,
                    damping: calculateDamping(index)
                )
                .speed(calculateSpeed(index)),
                value: scale
            )
    }
    
    private func calculateDamping(_ index: Int) -> Double {
        return damping - (Double(index) * dampingFactor)
    }
    
    private func calculateSpeed(_ index: Int) -> Double {
        return speed + (speedFactor * Double(index))
    }
    
    private func calculateOpacity(_ index: Int) -> Double {
        return baseOpacity - (opacityFactor * Double(index))
    }
}

struct TwitterLikeView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterLikeView()
    }
}
