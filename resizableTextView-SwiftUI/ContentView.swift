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
                    ForEach(Array(0...20).indices, id: \.self){ _ in
                        Comment()
                    }
                }
            }
            .padding(.horizontal, 12)

            VStack {
                HStack {
                    ResizableTF(txt: $txt, height: $height)
                        .frame(height: self.height < 150 ? self.height : 150)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(.black, lineWidth: 1)
                            )
                        .onTapGesture {
                        }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            HStack {
                HStack {
                    Text("[投稿ガイドライン](myappurl://action)").underline() +
                    Text("に関するテキスト")
                }.onOpenURL { link in

                }
                Spacer()
                HStack {
                    Text("00/000")
                    Button {
                        // action
                    } label: {
                        Text("投稿")
                            .frame(width: 64, height: 36)
                            .foregroundColor(.white)
                            .padding(13)
                    }
                    .background(.blue)
                    .cornerRadius(3)
                }
            }
            .padding(.horizontal, 12)
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


struct Comment: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("9999")
            Text("コメントテキスト文章文章文章コメントテキスト文章文章文章コメントテキスト文章文章文章コメントテキスト文章文章文章コメントテキスト文章文章文章")
            HStack {
                Text("0000-00-00 00:00:00:00")
                Text("通報")
                Spacer()
                Image("clear")
                Text("876")
            }
            Rectangle()
                .frame(height: 4)
                .background(.gray)
        }
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
        view.font = .systemFont(ofSize: 18)
        view.textColor = .gray
        view.backgroundColor = .clear

        let placeholderLabel = UILabel()
        placeholderLabel.text = "コメント入力に関するプレースホルダー"
        if let font = view.font {
            placeholderLabel.font = .italicSystemFont(ofSize: font.pointSize)
            placeholderLabel.frame.origin = CGPoint(x: 5, y: font.pointSize / 2)
        }
        placeholderLabel.sizeToFit()
        view.addSubview(placeholderLabel)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !view.text.isEmpty
        placeholderLabel.tag = 1

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
            textView.textColor = .black
            if let placeholder = textView.subviews.first(where: { $0.tag == 1 }) {
                placeholder.isHidden = !textView.text.isEmpty
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
                if let placeholder = textView.subviews.first(where: { $0.tag == 1 }) {
                    placeholder.isHidden = !textView.text.isEmpty
                }
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if let placeholder = textView.subviews.first(where: { $0.tag == 1 }) {
                placeholder.isHidden = !textView.text.isEmpty
            }
        }
    }
}
