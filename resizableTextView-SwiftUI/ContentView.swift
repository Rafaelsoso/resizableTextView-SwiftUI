//
//  ContentView.swift
//  Sample_Comment
//
//  Created by anh.nguyen3 on 22/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var profileText = "Enter your bio"
    
    var body: some View {
        Home()
        .padding()
        //.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

//#Preview {
//    ContentView()
//}

struct Home: View {
    @State var txt = ""
    @State var height: CGFloat = 0
    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("Chats")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }.padding()
            .background(Color.white)

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    // Chat content
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("xinchao")
                    Text("dsjfljsfjajdfajsdljaskdjklasjdlkajsdkljasdkljadksjaklsdjlkasjdklasjdljsaldjasjdlasjdlajsdjklsjdklasjdljasdjlasjdlajsdjasjdklajsdljaksjdlasjdljsadjksadjlasjdlsajdlajsdkjasasdjlsajdlksjkdljasdjasjdklasjdklsajdkajskldjasjdkasjdljasdjsldjlsajdlasjdjsaldjlsdjlasjdaksjdlsjdlajdlsjdljasdjlasjdkasjdl")
                }
            }

            HStack(spacing: 8) {
                ResizableTF(txt: $txt, height: $height)
                    .frame(height: self.height < 150 ? self.height : 150)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(15.0)
                    .onTapGesture {
                    }
                
                Button {
                    
                } label: {
                    Image("send")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .foregroundColor(.black)
                        .padding(13)
                }
                .background(.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)

            }
            .padding(.horizontal)
        }
        .padding(.bottom, self.keyboardHeight)
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.bottom))
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
//        .onAppear {
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) {(data) in
//                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
//                self.keyboardHeight = height1.cgRectValue.height - 20
//            }
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) {(_) in
//                self.keyboardHeight = 0
//            }
//        }
    }
}

struct ResizableTF: UIViewRepresentable {
    
    @Binding var txt: String
    @Binding var height: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return ResizableTF.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Enter Message"
        view.font = .systemFont(ofSize: 18)
        view.textColor = .gray
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ResizableTF

        init(parent1: ResizableTF) {
            self.parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.txt == "" {
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
