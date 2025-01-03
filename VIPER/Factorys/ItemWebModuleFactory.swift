//
//  ItemWebModuleFactory.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/26.
//

import SwiftUI

// navigationDestinationなどViewでPresenters、Routerのインスタンスを生成すると責務があやふやになってしまう為作成
class ItemWebModuleFactory: ModuleFactoryProtocol {
    
    @Binding var navigationPath: NavigationPath
    typealias PresenterType = ItemWebViewPresenter
    typealias ViewType = ItemWebView<ItemWebViewPresenter>
    typealias InputData = String
    
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    // 今回はモーダル遷移を使おうと思うのでnavigationPathとdiContainerは使わない（protcolに入れたのでやむなく。。。）
    static func createModule(navigationPath: Binding<NavigationPath>, diContainer: DIContainer, inputData: String?) -> ItemWebView<ItemWebViewPresenter> {
        let presenter = ItemWebViewPresenter(urlStr: inputData)
        return ItemWebView<ItemWebViewPresenter> (
            presenter: presenter
        )
    }
    

}
