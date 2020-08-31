//
//  CertificateCardView.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct CertificateCardView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showBottomCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    @State var showPercent = true
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20: 0)
                .opacity(showBottomCard ? 0.4: 1)
                .offset(y: showBottomCard ? -200: 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                    .repeatCount(3, autoreverses: false)
                )
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card3"): Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400: -40)
                .offset(viewState)
                .offset(y: showBottomCard ? -180: 0)
                .scaleEffect(showBottomCard ? 1: 0.95)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0: 10))
                .rotationEffect(.degrees(showBottomCard ? -10: 0))
                .rotation3DEffect(.degrees(10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
                
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4"): Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200: -20)
                .offset(viewState)
                .offset(y: showBottomCard ? -140: 0)
                .scaleEffect(showBottomCard ? 1: 0.95)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(show ? 0: 5))
                .rotationEffect(.degrees(showBottomCard ? -5: 0))
                .rotation3DEffect(.degrees(5), axis: (x: 5, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
                
            CardView()
                .frame(width: showBottomCard ? 375: 340.0, height: 220.0)
                .background(Color("card1"))
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showBottomCard ? 30: 20, style: .continuous))
                .shadow(radius: 20)
                .offset(self.viewState)
                .offset(y: showBottomCard ? -100: 0)
//                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                .onTapGesture {
                    self.showBottomCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged({ value in
                        self.viewState = value.translation
                        self.show = true
                        self.showBottomCard = false
                    })
                    .onEnded({ value in
                        self.viewState = .zero
                        self.show = false
                    })
                )
            
//            Text("\(bottomState.height)")
//                .offset(y: -300)
            
            BottomCardView(show: $showPercent)
                .offset(x: 0, y: showBottomCard ? 360: 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20: 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged({value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        })
                        .onEnded({value in
                            if self.bottomState.height > 50 {
                                self.showBottomCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) ||
                                (self.bottomState.height < -250 && self.showFull) {
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        })
            )
                
        }
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                    Text("Certificate")
                        .foregroundColor(Color("accent"))

                    
                }
                Spacer()
                Image("Logo2")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card2")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(20)
            Image("Card3")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(5)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
                .padding(.top, 10)
            HStack {
                RingView(color1: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), width: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut)
                    .padding(.vertical, 20)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Power Percent")
                        .font(.footnote)
                        .fontWeight(.bold)
                    
                    Text("78% Power is charging.\nIt takes me a long time.")
                        .font(.system(size: 12))
                        .lineSpacing(4)
                    
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(radius: 20)
            }
            Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateCardView()
    }
}
