//
//  ContentView.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 2.04.26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggeIn = false

    var body: some View {
        if userIsLoggeIn {
            ListView()
        } else {
            content
        }
    }

    var content: some View {
        ZStack {
            Color.black

            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .continuous)
                .fill(.linearGradient(colors: [.pink, .red],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing))
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
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.gray)
                    }

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundStyle(.white)

                SecureField("Password", text: $password)
                    .foregroundStyle(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundStyle(.white)
                            .bold()
                    }

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundStyle(.white)

                Button {
                    register()
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous)
                                .fill(.linearGradient(colors: [.pink, .red],
                                                      startPoint: .top,
                                                      endPoint: .bottomTrailing))
                        )
                        .foregroundStyle(.white)
                }

                Button {
                    login()
                } label: {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.top)
                .offset(y: 110)
            }
            .frame(width: 350)
            .onAppear {
                let _ = Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggeIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Ошибка входа \(error.localizedDescription)")
            } else {
                print("Пользователь успешно вошел в аккаунт")
            }

        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Ошибка авторизации \(error.localizedDescription)")
            } else {
                print("Пользователь успешно зарегистрирован")
            }

        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0)

            self
        }
    }
}

#Preview {
    ContentView()
}
