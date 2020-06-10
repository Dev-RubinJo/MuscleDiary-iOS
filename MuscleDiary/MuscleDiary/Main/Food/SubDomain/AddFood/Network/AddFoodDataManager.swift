//
//  AddFoodDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/21.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class AddFoodDataManager {
    
    func searchFoodByKeyword(vc: AddFoodVC, keyword: String) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        let searchApi = "\(ApiAddress.default)/foodList?keyword=\(keyword)"
        let encodedApi = searchApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        

        Alamofire.request("\(encodedApi)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<SearchFoodResponse>) in
                switch response.result {
                case .success(let searchResponse):
                    if searchResponse.code == 102 {
                        vc.searchFoodList.removeAll()
                        for food in searchResponse.result {
                            let foodData = Food(no: food.foodNo, name: food.foodName, carbohydrate: food.carbohydrate, protein: food.protein, fat: food.fat, calorie: food.calorie, servingSize: food.servingSize, serving: nil, region: food.region)
                            vc.searchFoodList.append(foodData)
                        }
                        vc.searchResultTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}
