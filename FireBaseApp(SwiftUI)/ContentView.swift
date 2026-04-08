//
//  ContentView.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 2.04.26.
//

import SwiftUI

import SwiftUI

// MARK: - Основное представление экрана входа
struct ContentView: View {
    // MARK: - Состояния (State Properties)
    // @State позволяет изменять значения внутри структуры View и автоматически обновлять UI
    @State private var email = ""      // Хранит введенный email
    @State private var password = ""   // Хранит введенный пароль

    // MARK: - Body (Пользовательский интерфейс)
    var body: some View {
        // ZStack - наложение элементов друг на друга по оси Z (глубине)
        ZStack {
            // 1. Фоновый цвет - черный на весь экран
            Color.black

            // 2. Декоративный элемент - большой повернутый прямоугольник с градиентом
            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .continuous)
                // Заливка линейным градиентом от розового к красному
                .fill(.linearGradient(colors: [.pink, .red],
                                      startPoint: .topLeading,    // Начало градиента: верхний левый угол
                                      endPoint: .bottomTrailing)) // Конец градиента: нижний правый угол
                .frame(width: 1000, height: 400)  // Размер прямоугольника
                .rotationEffect(.degrees(135))    // Поворот на 135 градусов
                .offset(y: -359)                  // Смещение по вертикали (создает диагональную полосу)

            // 3. Основной контент (форма входа)
            VStack(spacing: 20) {  // Vertical Stack - вертикальное расположение с отступом 20
                // Заголовок "Welcome"
                Text("Welcome")
                    .foregroundStyle(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded)) // Системный шрифт 40, жирный, скругленный
                    .offset(x: -100, y: -100)                   // Смещение влево и вверх

                // Поле ввода Email
                TextField("Email", text: $email)  // $email - двусторонняя привязка (binding)
                    .foregroundStyle(.white)       // Цвет вводимого текста
                    .textFieldStyle(.plain)        // Простой стиль без рамки
                    // Кастомный плейсхолдер (отображается когда поле пустое)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.gray)  // Серый цвет для плейсхолдера
                    }

                // Разделительная линия под полем Email
                Rectangle()
                    .frame(width: 350, height: 1)  
                    .foregroundStyle(.white)

                // Поле ввода пароля (SecureField скрывает вводимые символы)
                SecureField("Password", text: $password)
                    .foregroundStyle(.white)
                    .textFieldStyle(.plain)
                    // Кастомный плейсхолдер для поля пароля
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundStyle(.white)
                            .bold()  // Жирное начертание
                    }

                // Разделительная линия под полем пароля
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundStyle(.white)

                // Кнопка "Sign in" (войти)
                Button {
                    // TODO: Добавить логику входа
                    // Здесь будет код авторизации
                } label: {
                    Text("Sign in")
                        .bold()                              // Жирный текст
                        .frame(width: 200, height: 40)       // Фиксированный размер кнопки
                        .background(
                            // Скругленный прямоугольник для фона кнопки
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous)
                                .fill(.linearGradient(colors: [.pink, .red],
                                                      startPoint: .top,           // Градиент сверху
                                                      endPoint: .bottomTrailing)) // ...вниз-вправо
                        )
                        .foregroundStyle(.white)  // Цвет текста кнопки
                }

                // Кнопка "Already have an account? Login" (уже есть аккаунт? Войти)
                Button {
                    // TODO: Добавить навигацию на экран входа
                    // Здесь будет переход на экран логина
                } label: {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.top)    // Отступ сверху
                .offset(y: 110)   // Смещение вниз (приподнимает кнопку над декоративным элементом)
            }
            .frame(width: 350)  // Фиксированная ширина VStack
        }
        .ignoresSafeArea()  // Игнорирует безопасные зоны (занимает весь экран, включая Dynamic Island и панель индикаторов)
    }
}

// MARK: - Расширение View для кастомного плейсхолдера
extension View {
    /// Добавляет кастомный плейсхолдер для текстовых полей
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

// MARK: - Preview для SwiftUI Canvas
#Preview {
    ContentView()
}
