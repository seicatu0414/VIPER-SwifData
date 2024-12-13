//
//  UserDetailViewRouter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/06.
//

import SwiftUI
// Task内で呼ばれるため＠MainActorをプロトコルに付与
@MainActor
protocol UserDetailViewRouterProtocol {
    func pushToUserDetail(userData: SearchUser)
    func popToPreviousView()
}


class UserDetailViewRouter: UserDetailViewRouterProtocol {
    @Binding var navigationPath: NavigationPath
    static let userDetailPath: String = "/UserDetail"
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    // プッシュ遷移
    func pushToUserDetail(userData: SearchUser) {
        navigationPath.append(userData)
        
    }
    
    // ポップ遷移
    func popToPreviousView() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
}
