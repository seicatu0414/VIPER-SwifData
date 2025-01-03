//
//  FollowerAndFolloweeModuleFactory.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/30.
//

import SwiftUI

class FollowerAndFolloweeModuleFactory: @preconcurrency ModuleFactoryProtocol {
    typealias PresenterType = FllowerAndFolloweePresenter
    typealias ViewType = FollowerAndFolloweeView<FllowerAndFolloweePresenter>
    typealias InputData = FollowerAndFolloweeData
    @Binding var navigationPath: NavigationPath
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    
    @MainActor
    static func createModule(navigationPath: Binding<NavigationPath>, diContainer: DIContainer, inputData: FollowerAndFolloweeData?) -> FollowerAndFolloweeView<FllowerAndFolloweePresenter> {
        let router = FllowerAndFolloweeRouter(navigationPath: navigationPath)
        let presenter = FllowerAndFolloweePresenter(apiInteractor: diContainer.apiInteractor, router: router,userIdStr: inputData!.userId)
        return FollowerAndFolloweeView<FllowerAndFolloweePresenter> (
            presenter: presenter, followerAndFollowee: inputData!.type
        )
    }
    

}
