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
    typealias InputData = Void
    
    @MainActor
    static func createModule(navigationState: NavigationState,diContainer: DIContainer, inputData: Void?) -> SearchUserView<SearchUserPresenter> {
        let router = SearchUserViewRouter(navigationState: navigationState)
        let presenter = SearchUserPresenter(
            apiInteractor: diContainer.apiInteractor,
            swiftDataInteractor: diContainer.swiftDataInteractor,
            router: router
        )
        return SearchUserView<SearchUserPresenter>(
            presenter: presenter
        )
    }
}
