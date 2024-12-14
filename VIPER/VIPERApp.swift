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
    var diContainer: DIContainer
    @State private var navigationPath = NavigationPath()
    
    init() {
        // sharedModelContainerの初期化
        sharedModelContainer = SharedModelContainer.shared.modelContainer
        diContainer = DIContainer.shared
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                SearchUserModuleFactory.createModule(navigationPath: $navigationPath, diContainer: diContainer)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
