//
//  UserDetailModuleFactory.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/15.
//

import SwiftUI

// navigationDestinationなどViewでPresenters、Routerのインスタンスを生成すると責務があやふやになってしまう為作成
class UserDetailModuleFactory: @preconcurrency ModuleFactoryProtocol {
    typealias PresenterType = UserDetailPresenter
    typealias ViewType = UserDetailView<UserDetailPresenter>
    @Binding var navigationPath: NavigationPath
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }

    @MainActor
    static func createModule(
        navigationPath: Binding<NavigationPath>,
        diContainer: DIContainer
    ) -> UserDetailView<UserDetailPresenter> {
        let router = UserDetailRouter(navigationPath: navigationPath)
        let presenter = UserDetailPresenter(
            apiInteractor: diContainer.apiInteractor,
            swiftDataInteractor: diContainer.swiftDataInteractor,
            router: router
        )
        return UserDetailView<UserDetailPresenter> (
            navigationPath: navigationPath,
            presenter: presenter
        )
    }
}
