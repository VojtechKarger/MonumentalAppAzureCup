//
//  WelcomeView.swift
//  Playground
//
//  Created by vojta on 22.05.2021.
//

import SwiftUI

enum StateNow {
    case loading, first, second, hide, confirmPic
}


struct WelcomeView: View {
    let screen = UIScreen.main.bounds
    
    @EnvironmentObject var vm: ChatBotModel

    @State private var btnText = "Next"
    
    @Binding var firstTime: Bool
    
    @State private var currentState: StateNow = .loading
    
    @Binding var dismiss: Bool
    
    @State private var animation1: CGFloat = -15
    @State private var animation2: CGFloat = 15
    @State private var animation3: CGFloat = 15
    @State private var animation4: CGFloat = 0
    
    @State private var middle: CGFloat = 0
    
    @AppStorage("image") var image: Data = Data(count: 0)
    
    @State private var presenting = false
    
    var body: some View {
        ZStack{
            Color.firstBG.ignoresSafeArea()
            My(animation1: animation1, animation2: animation2, animation3: animation3,animation4: animation4)
                .fill(Color.azure2)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Image("Bot")
                        .resizable()
                        .scaledToFill()
                        .frame(width: screen.width / 3.5, height: screen.width / 3.5, alignment: .center)
                        .offset(x: (middle == 0) ? -screen.width / 2 : 0)
                        .animation(.spring(response: 1.5, dampingFraction: 0.8, blendDuration: 100.0))
                    ZStack{
                        MessageBubble(message: "Hello, I am Peter \n And I will be your Prague guide.").offset(y: -screen.height * (middle - 1))
                        MessageBubble(message: "I can ansewer your messages or even to your images.").offset(y: -screen.height * (middle - 2))
                        MessageBubble(message: "Now please chose your profile picture.").offset(y: -screen.height * (middle - 3))
                        ProfilePicConfirm().offset(y: -screen.height * (middle - 4))
                    }
                }

                Spacer()
                
                
                HStack{
                    
                }
                
                Button(action: animation, label: {
                    Text(btnText)
                }).buttonStyle(NextButton())
                .padding(.bottom)
                .offset(y: (middle == 0) ? screen.height / 2 : 0)
                .animation(.spring(response: 1.5, dampingFraction: 0.8, blendDuration: 100.0))
            }
        }.onAppear(perform: {
            withAnimation(.spring(response: 1.5, dampingFraction: 0.8, blendDuration: 100.0).delay(4)){
                animation()
            }
        })
        .sheet(isPresented: $presenting, content: {
            ImagePicker2(image: $image)
        })
        .transition(.opacity)
    }
    
    
    
    
    func animation() {
        if middle < 4 {
            withAnimation(.spring(response: 1.5, dampingFraction: 0.8, blendDuration: 100.0)){
                middle += 1
            }
        }else {
            middle = 0
        }
        withAnimation(Animation.spring(response: 1, dampingFraction: 0.8, blendDuration: 100.0)){
            switch currentState{
            case .loading:
                animation1 = 0.01867
                animation2 = 0.68366
                animation3 = 0.99466
                animation4 = 0.47676
                currentState = .first
            case .first:
                animation1 = 1
                animation2 = 1
                animation3 = 1
                animation4 = -1
                currentState = .second
            case .second:
                animation1 = 0.5
                animation2 = 1
                animation3 = 0.5
                animation4 = 0.5
                currentState = .hide
                btnText = "Choose"
            case .hide:
                currentState = .confirmPic
                DispatchQueue.main.async {
                    presenting = true
                }
                btnText = "Confirm"
                
            case .confirmPic:
                btnText = "Next"
                animation1 = -15
                animation2 = 15
                animation3 = 15
                animation4 = 0
                currentState = .loading
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                    withAnimation{
                        dismiss.toggle()
                        firstTime.toggle()
                        vm.chatbotTyping = true
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.2) {
                            vm.messages.append(Message(who: .bot, message: "Hello What can I help you with?"))
                            vm.chatbotTyping = false
                        }
                        
                    }
                }
            }
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(firstTime: .constant(false), dismiss: .constant(false))
    }
}

struct NextButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .foregroundColor(.primary)
            .frame(width: UIScreen.main.bounds.width - 50)
            .background(Color.ghostWhite)
            .clipShape(RoundedRectangle(cornerRadius: 17
            ))
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}


struct Bubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0.49013*height))
        path.addCurve(to: CGPoint(x: 0.5367*width, y: 0.98026*height), control1: CGPoint(x: width, y: 0.76082*height), control2: CGPoint(x: 0.792*width, y: 0.99839*height))
        path.addCurve(to: CGPoint(x: 0.07727*width, y: 0.49013*height), control1: CGPoint(x: -0.27848*width, y: 0.92235*height), control2: CGPoint(x: 0.07727*width, y: 1.2427*height))
        path.addCurve(to: CGPoint(x: 0.5367*width, y: 0), control1: CGPoint(x: 0.07727*width, y: 0.21508*height), control2: CGPoint(x: 0.28082*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.49013*height), control1: CGPoint(x: 0.79257*width, y: 0), control2: CGPoint(x: width, y: 0.21944*height))
        path.closeSubpath()
        return path
    }
}


struct My: Shape {
    var animation1: CGFloat
    var animation2: CGFloat
    var animation3: CGFloat
    var animation4: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat,AnimatablePair<CGFloat,CGFloat>>>{
        get{ AnimatablePair(animation1, AnimatablePair(animation2, AnimatablePair(animation3, animation4)))  }
        set{
            animation1 = newValue.first
            animation2 = newValue.second.first
            animation3 = newValue.second.second.first
            animation4 = newValue.second.second.second
        }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.616*width, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: -0.00267*width, y: height))
        path.addCurve(to: CGPoint(x: 0.616*width, y: 0),
                      control1:
                        CGPoint(x: animation1 * width, y: animation2 * height)
                      ,control2: CGPoint(x: animation3 * width, y: animation4 * height))
        path.closeSubpath()
        return path
    }
}



struct MessageBubble: View {
    
    var message: String
    let screen = UIScreen.main.bounds

    
    var body: some View {
        ZStack {
            Bubble()
                .fill(Color.ghostWhite)
            Text(message)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 20).bold())
                .padding(40)
        }.frame(width: screen.width / 1.5, height: screen.width / 2, alignment: .center)
        .padding(.bottom, screen.width / 7)
    }
}


struct ProfilePicConfirm: View {
    let screen = UIScreen.main.bounds
    
    @AppStorage("image") var image: Data = Data(count: 0)
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.azure2)
                .frame(width: screen.width / 2, height: screen.width / 2, alignment: .center)
            Image(uiImage: UIImage(data: image) ?? UIImage(named: "user")!)
                .resizable()
                .scaledToFill()
                .frame(width: screen.width / 2 - 15, height: screen.width / 2 - 15, alignment: .center)
                .clipShape(Circle())
        }
    }
}
