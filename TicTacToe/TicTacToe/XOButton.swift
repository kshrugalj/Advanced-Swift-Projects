//
//  XOButton.swift
//  TicTacToe
//
//  Created by Kshrugal Reddy Jangalapalli on 2/8/25.
//

import SwiftUI

struct XOButton: View {
    
    
    @Binding var letter: String//used for letter in preview
    @State private var degrees = 0.0//used for spin motion
    
    var body: some View {
        ZStack {
            Circle().frame(width: 120, height: 120).foregroundColor(.blue)//first blue circle
            Circle().frame(width: 100, height: 100).foregroundColor(.white)//than white circle
            Text(letter).font(.system(size:50)).bold()//calling letter to X and adjusting font size and making it bold
            
        }
        .rotation3DEffect(.degrees(degrees), axis: (x:0, y: 1, z: 0))//used for the rotation animation
        .simultaneousGesture(TapGesture().onEnded{_ in withAnimation(.easeIn(duration: 0.25)){
            self.degrees -= 180
        }
        }
                             
        )}
}

#Preview {
    XOButton(letter: .constant("X"))//setting button to 'X'
}
