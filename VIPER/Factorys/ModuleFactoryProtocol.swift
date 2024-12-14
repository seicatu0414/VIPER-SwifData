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
    var navigationPath: NavigationPath { get }
    static func createModule(
        navigationPath: Binding<NavigationPath>,
        diContainer: DIContainer
    ) -> ViewType
}
