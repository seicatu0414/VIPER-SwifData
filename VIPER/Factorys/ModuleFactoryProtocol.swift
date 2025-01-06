//
//  ModuleFactoryProtocol.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/15.
//

import SwiftUI
// マルチモジュール化、疎結合を意識してProtocol作成
// このアプリでするかは知らん。
protocol ModuleFactoryProtocol {
    associatedtype PresenterType
    associatedtype ViewType: View
    associatedtype InputData = Void
    static func createModule(
        navigationState: NavigationState,
        diContainer: DIContainer,
        inputData: InputData?
    ) -> ViewType
}
