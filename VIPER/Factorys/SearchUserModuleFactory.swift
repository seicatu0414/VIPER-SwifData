//
//  SearchUserModuleFactory.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/15.
//

import SwiftUI

// navigationDestinationなどViewでPresenters、Routerのインスタンスを生成すると責務があやふやになってしまう為作成
class SearchUserModuleFactory: @preconcurrency ModuleFactoryProtocol {
    typealias PresenterType = SearchUserPresenter
    typealias ViewType = SearchUserView<SearchUserPresenter>
    @Binding var navigationPath: NavigationPath
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }

    @MainActor
    static func createModule(
        navigationPath: Binding<NavigationPath>,
        diContainer: DIContainer
    ) -> SearchUserView<SearchUserPresenter> {
        let router = SearchUserViewRouter(navigationPath: navigationPath)
        let presenter = SearchUserPresenter(
            apiInteractor: diContainer.apiInteractor,
            swiftDataInteractor: diContainer.swiftDataInteractor,
            router: router
        )
        return SearchUserView<SearchUserPresenter>(
            navigationPath: navigationPath,
            presenter: presenter
        )
    }
}
