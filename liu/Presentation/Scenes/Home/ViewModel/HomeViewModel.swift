import Foundation

final class HomeViewModel: ObservableObject {
    @Published private(set) var dashboardItems: [DashboardItem] = []
    @Published private(set) var userName: String = ""

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        loadDashboardItems()
        loadUser()
    }

    private func loadUser() {
        Task {
            if let user = await authRepository.getCurrentUser() {
                await MainActor.run {
                    self.userName = user.name
                }
            }
        }
    }

    private func loadDashboardItems() {
        dashboardItems = [
            DashboardItem(
                icon: "person.circle.fill", title: Constants.LocalizationKeys.profile,
                colorType: .blue),
            DashboardItem(
                icon: "bell.fill", title: Constants.LocalizationKeys.notifications,
                colorType: .orange),
            DashboardItem(
                icon: "message.fill", title: Constants.LocalizationKeys.messages, colorType: .green),
            DashboardItem(
                icon: "gearshape.fill", title: Constants.LocalizationKeys.settings,
                colorType: .purple),
        ]
    }
}

struct DashboardItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let colorType: ItemColor

    enum ItemColor {
        case blue, orange, green, purple
    }
}
