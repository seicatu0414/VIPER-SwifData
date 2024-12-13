//
//  ModelContextEx.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//

import SwiftData
import Foundation

extension ModelContext {
    /// 指定された条件でエンティティを検索し、見つからない場合は新規作成するヘルパーメソッド
    /// createには保存したい構造体が入る
    func findOrInsert<T: PersistentModel>(
        matching predicate: Predicate<T>,
        create: @autoclosure () -> T
    ) throws -> T {
        let fetchDescriptor = FetchDescriptor<T>()
        let results = try self.fetch(fetchDescriptor)
        if let existing = results.first {
            return existing 
        } else {
            let newObject = create()
            // SwiftDataに追加
            self.insert(newObject)
            return newObject
        }
    }
}
