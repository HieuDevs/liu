import SwiftUI

@MainActor
class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var root: AppRoute = .splash

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }

    func setRoot(_ route: AppRoute) {
        self.root = route
        self.path = NavigationPath()
    }
}
