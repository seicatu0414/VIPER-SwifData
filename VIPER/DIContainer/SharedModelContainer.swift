//
//  SharedModelContainer.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/15.
//

import SwiftData

public class SharedModelContainer {
    //staticは初めてコールされた時にインスタンス化され変数のみメモリに保持される
    static let shared = SharedModelContainer()
    let modelContainer: ModelContainer
    
    @MainActor
    var mainContext: ModelContext {
        modelContainer.mainContext
    }

    private init() {
        // 新たな＠Modelエンティティはここに追加
        let schema = Schema([
            LookedUser.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
