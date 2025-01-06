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

    
    @MainActor
    static func createModule(navigationState: NavigationState,diContainer: DIContainer, inputData: FollowerAndFolloweeData?) -> FollowerAndFolloweeView<FllowerAndFolloweePresenter> {
        let router = FllowerAndFolloweeRouter(navigationState: navigationState)
        let presenter = FllowerAndFolloweePresenter(apiInteractor: diContainer.apiInteractor, router: router,userIdStr: inputData!.userId)
        return FollowerAndFolloweeView<FllowerAndFolloweePresenter> (
            presenter: presenter, followerAndFollowee: inputData!.type
        )
    }
    

}
