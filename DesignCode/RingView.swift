//
//  RingView.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var color1: Color = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    var color2: Color = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var width: CGFloat = 300
    var height: CGFloat = 300
    var percent: CGFloat = 20
    @Binding var show: Bool
    
    var body: some View {
        let multiplier = width / 44
        let progress = 1 - percent / 100
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: self.width, height: self.height)
                
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [self.color1, self.color2]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 10))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: self.width, height: self.height)
//                .animation(.easeInOut)
//                .shadow(color: self.color2.opacity(Double(self.percent)), radius: 3, x: 0, y: 3 * multiplier)
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
                }
        }.padding()
        
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
