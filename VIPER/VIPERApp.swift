//
//  VIPERApp.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//

import SwiftUI
import SwiftData


@main
struct VIPERApp: App {
    var sharedModelContainer: ModelContainer
    var diContainer: SearchUserDIContainer
    @State private var navigationPath = NavigationPath()
    
    init() {
        // sharedModelContainerの初期化
        sharedModelContainer = {
            // 新たな＠Modelエンティティはここに追加
            let schema = Schema([
                LookedUser.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        // diContainerの初期化
        let apiInteractor = APIInteractor()
        // sharedModelContainerを先にinitしないとmainContextが使えない
        let swiftDataInteractor = SwiftDataInteractor(modelContext: sharedModelContainer.mainContext)

        diContainer = SearchUserDIContainer(apiInteractor: apiInteractor, swiftDataInteractor: swiftDataInteractor)
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                // 本当はDIコンテナの中に含めたかったが、VIPERApp: Appのinit内で$navigationPathが参照できない為ここに移動
                let router = UserDetailViewRouter(navigationPath: $navigationPath)
                let presenter = SearchUserPresenter(
                    apiInteractor: diContainer.apiInteractor,
                    swiftDataInteractor: diContainer.swiftDataInteractor,
                    router: router
                )
                SearchUserView(navigationPath: $navigationPath, presenter: presenter)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
