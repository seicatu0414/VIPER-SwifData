//
//  VIPERApp.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//

import SwiftUI
import SwiftData

class NavigationState: ObservableObject {
    @Published var navigationPath: NavigationPath = NavigationPath()
}

@main
struct VIPERApp: App {
    var sharedModelContainer: SharedModelContainer
    var diContainer: DIContainer
    @StateObject private var navigationState = NavigationState()
    
    init() {
        // sharedModelContainerの初期化
        sharedModelContainer = SharedModelContainer.shared
        diContainer = DIContainer.shared
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.navigationPath) {
                SearchUserModuleFactory.createModule(navigationState: navigationState, diContainer: diContainer, inputData: nil)
                    .environmentObject(sharedModelContainer) // SharedModelContainerを渡す
                    .environmentObject(navigationState)
            }
        }
        // 消してもSwiftDataに保存する（なぜ？）
        .modelContainer(sharedModelContainer.modelContainer)
    }
}
