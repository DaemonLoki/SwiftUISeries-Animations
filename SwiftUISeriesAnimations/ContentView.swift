//
//  ContentView.swift
//  SwiftUISeriesAnimations
//
//  Created by Stefan Blos on 23.05.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 200) {
            TwitterLikeView()
            
            MediumClapView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
