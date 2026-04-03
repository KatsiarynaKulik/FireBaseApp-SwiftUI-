//
//  ContentView.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 2.04.26.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Color.black

//            RoundedRectangle(cornerSize: 30, style: .continuous)
//                .foregroundStyle(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .frame(width: 1000, height: 400)
//                .rotationEffect(.degrees(135))
//                .offset(y: -359)

            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .continuous)
                .fill(.linearGradient(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -359)

            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundStyle(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)

                TextField("Email", text: $email)
                    .foregroundStyle(.white)
                    .textFieldStyle(.plain)
                   // .placeholder(when: email.isEmpty)
                Text("Email")
                    .foregroundStyle(.white)
                    .bold()

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundStyle(.white)

                SecureField("Password", text: $password)
                    .foregroundStyle(.white)
                    .textFieldStyle(.plain)
                // .placeholder(when: password.isEmpty)
                Text("Password")
                    .foregroundStyle(.white)
                    .bold()

                Button {

                } label: {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.top)
                .offset(y: 110)

            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

#Preview {
    ContentView()
}
