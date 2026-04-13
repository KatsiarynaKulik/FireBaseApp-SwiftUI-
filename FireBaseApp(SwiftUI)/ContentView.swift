//
//  ContentView.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 2.04.26.
//

import SwiftUI
import Firebase
import FirebaseAuth

// MARK: - Основное представление экрана входа
struct ContentView: View {
    // MARK: - Состояния (State Properties)
    // @State позволяет изменять значения внутри структуры View и автоматически обновлять UI
    @State private var email = ""      // Хранит введенный email
    @State private var password = ""   // Хранит введенный пароль
    @State private var userIsLoggeIn = false

    // MARK: - Body (Пользовательский интерфейс)
    var body: some View {
        // ZStack - наложение элементов друг на друга по оси Z (глубине)
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
            onAppear {
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
    /// - Parameters:
    ///   - shouldShow: Условие отображения плейсхолдера (обычно когда поле пустое)
    ///   - alignment: Выравнивание плейсхолдера (по умолчанию .leading - левый край)
    ///   - placeholder: Замыкание, возвращающее View для плейсхолдера
    /// - Returns: View с наложенным плейсхолдером
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content  // @ViewBuilder позволяет передавать несколько вью
    ) -> some View {
        // ZStack накладывает плейсхолдер поверх исходного View
        ZStack(alignment: alignment) {
            // Плейсхолдер отображается только когда shouldShow = true
            placeholder()
                .opacity(shouldShow ? 1 : 0)  // Прозрачность: 1 - видим, 0 - скрыт

            // Исходное View (TextField или SecureField)
            self
        }
    }
}

#Preview {
    ContentView()
}
