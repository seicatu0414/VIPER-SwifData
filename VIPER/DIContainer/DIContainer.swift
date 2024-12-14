//
//  DIContainer.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/12.
//

// シングルトンインスタンス
@MainActor
public class DIContainer {
    //staticは初めてコールされた時にインスタンス化され変数のみメモリに保持される
    static let shared = DIContainer(apiInteractor: APIInteractor(), swiftDataInteractor: SwiftDataInteractor(modelContext: SharedModelContainer.shared.mainContext))
    let apiInteractor: APIInteractorProtocol
    let swiftDataInteractor: SwiftDataInteractorProtocol
    
    private init(apiInteractor: APIInteractorProtocol, swiftDataInteractor: SwiftDataInteractorProtocol) {
        self.apiInteractor = apiInteractor
        self.swiftDataInteractor = swiftDataInteractor
    }
}
