//
//  MediumClapView.swift
//  SwiftUISeriesAnimations
//
//  Created by Stefan Blos on 23.05.22.
//

import SwiftUI

struct MediumClapView: View {
    
    let size: CGFloat = 100
    let speed = 1.0
    let duration = 0.8
    
    @State private var rotationDegrees = 0.0
    @State private var yOffset: CGFloat = 0
    @State private var xOffset: CGFloat = 0
    @State private var opacity = 0.0
    
    @State private var gradientOpacity = 0.0
    @State private var gradientOffset: CGFloat = -200
    
    @State private var firstColor: Color = .gray
    @State private var secondColor: Color = .gray
    
    @State private var sparkleXOffset: CGFloat = 0
    @State private var sparkleYOffset: CGFloat = -110
    @State private var sparkleScale: CGFloat = 2.0
    @State private var sparkleOpacity = 0.0
    @State private var sparkleRotation = 20.0
    
    var body: some View {
        ZStack {
            Image(systemName: "hands.clap.fill")
                .resizable()
                .foregroundColor(.gray)
                .opacity(0.5)
                .frame(width: size, height: size)
            
            Image(systemName: "hands.clap")
                .resizable()
                .foregroundColor(firstColor)
                .frame(width: size, height: size)
                .rotation3DEffect(.degrees(rotationDegrees), axis: (x: 0, y: 1, z: 0), anchor: .center)
                .offset(x: xOffset, y: yOffset)
                .opacity(opacity)
            
            Image(systemName: "hands.clap")
                .resizable()
                .foregroundColor(secondColor)
                .frame(width: size, height: size)
                .rotation3DEffect(.degrees(-rotationDegrees), axis: (x: 0, y: 1, z: 0), anchor: .center)
                .offset(x: -xOffset, y: yOffset)
                .opacity(opacity)
            
            LinearGradient(colors: [.orange, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 100, height: 100)
                .offset(y: gradientOffset)
                .opacity(gradientOpacity)
                .mask {
                Image(systemName: "hands.clap.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: size, height: size)
            }
            
            ForEach(0...5, id: \.self) { i in
                Image(systemName: "sparkle")
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(Double(i + 20) * sparkleRotation))
                    .scaleEffect(sparkleScale * (Double(i) * 0.9))
//                    .offset(x: CGFloat(i) * sparkleXOffset, y: sparkleYOffset)
                    .offset(y: sparkleYOffset)
                    .opacity(sparkleOpacity)
            }
            
        }
        .onTapGesture {
            gradientOpacity = 0.0
            gradientOffset = -200
            xOffset = 0
            yOffset = 0
            sparkleXOffset = 5
            sparkleYOffset = -110
            sparkleOpacity = 0.0
            sparkleScale = 0.0
            sparkleRotation = 20.0
            opacity = 0.6
            
            // hands rotation + yOffset + opacity
            withAnimation(
                .easeIn(duration: duration)
                .repeatCount(2, autoreverses: true)
            ) {
                rotationDegrees = 360 * 1
                yOffset += -110
                opacity = 0.6
            }
            
            // hands xOffset
            withAnimation(
                .easeIn(duration: duration / 2)
                .repeatCount(4, autoreverses: true)
            ) {
                
                xOffset += 30
            }
            
            // hands color change
            withAnimation(
                .easeIn(duration: duration / 2)
                .delay(duration / 2)
                .repeatCount(2, autoreverses: true)
            ) {
                    firstColor = .blue
                    secondColor = .orange
                }
            
            // gradient animation
            DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.3) {
                withAnimation(.easeIn(duration: duration / 2)) {
                    gradientOpacity = 1
                    gradientOffset += 200
                }
            }
            
            // sparkles animation
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                sparkleOpacity = 0.4
                withAnimation(
                    .easeOut(duration: duration * 2)) {
                        sparkleXOffset += 40
                        sparkleScale = 4.0
                        sparkleOpacity = 0.0
                        sparkleRotation = 50
                    }
                
            }
            
            // reset hands elements
            DispatchQueue.main.asyncAfter(deadline: .now() + (duration * 2) - 0.2, execute: {
                rotationDegrees = 0
                yOffset = 0
                xOffset = 0
                opacity = 0
                firstColor = .gray
                secondColor = .gray
            })
        }
    }
}

struct MediumClapView_Previews: PreviewProvider {
    static var previews: some View {
        MediumClapView()
            .preferredColorScheme(.dark)
    }
}
