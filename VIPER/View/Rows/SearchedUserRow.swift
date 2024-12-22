//
//  SearchedUserRow.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/09.
//

import SwiftUI

struct SearchedUserRow: View {
    var userImageData:Data
    var userName:String
    var userFlowerCnt:String
    var userFloweeCnt:String
    
    init(userImageData: Data, userName: String, userFlowerCnt: String, userFloweeCnt: String) {
        self.userImageData = userImageData
        self.userName = userName
        self.userFlowerCnt = userFlowerCnt
        self.userFloweeCnt = userFloweeCnt
    }
    
    var body: some View {
           GeometryReader { geometry in
               HStack(alignment: .center) {
                   if let uiImage = UIImage(data: userImageData) {
                       Image(uiImage: uiImage)
                           .resizable()
                           .scaledToFill()
                           .frame(width: 50, height: 50)
                           .clipShape(Circle())
                           .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                           .shadow(radius: 3)
                   } else {
                       Circle()
                           .fill(Color.gray)
                           .frame(width: 50, height: 50)
                           .overlay(Text("?").foregroundColor(.white))
                   }

                   VStack(alignment: .leading, spacing: 4) {
                       Text(userName)
                           .font(.headline)
                       HStack {
                           Text("フォロワー: \(userFloweeCnt)")
                               .font(.footnote)
                               .foregroundColor(.secondary)
                           Text("フォロー: \(userFlowerCnt)")
                               .font(.footnote)
                               .foregroundColor(.secondary)
                       }
                   }
                   Spacer()
               }
               .frame(width: geometry.size.width)
               //　無効なフレーム寸法 (負または非有限)らしい
               // ちなみにマイナス値にフレームがなった場合その正の値が返る。
               //.frame(width: .infinity)
           }
           .frame(height: 60)
       }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchedUserRow(userImageData: sampleImageData(), userName: "Seicatu", userFlowerCnt: "30000", userFloweeCnt: "30000")
    }
}

// サンプルデータ用関数
private func sampleImageData() -> Data {
    // システム画像を使用（任意の画像に置き換え可能）
    let image = UIImage(systemName: "person.circle")!
    return image.jpegData(compressionQuality: 1.0)!
}
