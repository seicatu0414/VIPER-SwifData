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
    typealias InputData = SearchUser

    @MainActor
    static func createModule(navigationState: NavigationState,diContainer: DIContainer, inputData: SearchUser?) -> UserDetailView<UserDetailPresenter> {
        let router = UserDetailRouter(navigationState: navigationState)
        let presenter = UserDetailPresenter(
            apiInteractor: diContainer.apiInteractor,
            swiftDataInteractor: diContainer.swiftDataInteractor,
            router: router,
            userData: inputData!
        )
        return UserDetailView<UserDetailPresenter> (
            presenter: presenter
        )
    }

}
