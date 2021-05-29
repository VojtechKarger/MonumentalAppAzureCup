//

import SwiftUI

struct SpeechToTextView: View {
    @EnvironmentObject var vm: ChatBotModel
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                let frame = geo.frame(in: .global)
                Wrapper()
                    .frame(width: frame.width, height: frame.height)
                    .onAppear {
                        print(frame)
                    }
            }.frame(height: 200)
            VStack{
                Divider()
                    .background(Color.azure)
                HStack{
                    Spacer()
                    Button(action: {
                        vm.hideRecordingScreen()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.azure)
                            .frame(width: 30, height: 30, alignment: .center)
                            .rotationEffect(Angle(degrees: 45))
                    })
                    .padding(.trailing, 10)
                    
                }
                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width ,height: 200)
        .background(Color.white)
        .offset(y: vm.showingRecordingScreen ? 0 : 800)
        .sheet(isPresented: $vm.showing){
            if vm.takeingPhoto == true {
                ImagePicker(vm: vm, type: .camera).onAppear(perform: {
                    vm.loading = false
                })
            }else {
                ImagePicker(vm: vm, type: .photoLibrary)
            }
        }
    }
}

struct SpeechToTextView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechToTextView()
    }
}
