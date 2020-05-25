//
//  ChartDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class ChartDataManager {
    
    func addChartData(fromVC vc: ChartVC, weight: Double, date: String) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        let parameters: Parameters = [
            "weight": weight,
            "recordDate": date
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/weight", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    print(defaultResponse)
                    vc.date = vc.dateFormatter.string(from: Date())
                    if vc.chartDate == 1 {
                        self.retrieveWeekData(fromVC: vc)
                    } else if vc.chartDate == 2 {
                        self.retrieveMonthData(fromVC: vc)
                    } else if vc.chartDate == 3 {
                        self.retrieveYearData(fromVC: vc)
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func retrieveWeekData(fromVC vc: ChartVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/weekly/weight?weekDate=\(vc.date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ChartResponse>) in
                switch response.result {
                case .success(let chartResponse):
                    print(chartResponse)
                    if chartResponse.code == 102 {
                        if let chartList = chartResponse.result {
                            var temp = 0
                            for data in chartList {
                                if let xData = data.date, let yData = data.weight {
                                    let tempDateList = xData.components(separatedBy: "-")
                                    let day = tempDateList[2]
                                    
                                    let chartData = ChartData(x: Double(temp), y: yData, date: xData)
                                    vc.chartData.append(chartData)
                                    temp += 1
                                }
                            }
                            //                            vc.setChartView()
                            vc.updateChartData()
                            vc.dataTableView.reloadData()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func retrieveMonthData(fromVC vc: ChartVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        Alamofire.request("\(ApiAddress.default)/user/weekly/weight?monthDate=\(vc.date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ChartResponse>) in
                switch response.result {
                case .success(let chartResponse):
                    print(chartResponse)
                    
                    if chartResponse.code == 102 {
                        if let chartList = chartResponse.result {
                            var temp = 0
                            for data in chartList {
                                if let xData = data.date, let yData = data.weight {
                                    let tempDateList = xData.components(separatedBy: "-")
                                    let day = tempDateList[2]
                                    
                                    let chartData = ChartData(x: Double(temp), y: yData, date: xData)
                                    vc.chartData.append(chartData)
                                    temp += 1
                                }
                            }
                            //                            vc.setChartView()
                            vc.updateChartData()
                            vc.dataTableView.reloadData()
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func retrieveYearData(fromVC vc: ChartVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        Alamofire.request("\(ApiAddress.default)/user/weekly/weight?yearDate=\(vc.date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ChartResponse>) in
                switch response.result {
                case .success(let chartResponse):
                    print(chartResponse)
                    if chartResponse.code == 102 {
                        if let chartList = chartResponse.result {
                            var temp = 0
                            for data in chartList {
                                if let xData = data.date, let yData = data.weight {
                                    let tempDateList = xData.components(separatedBy: "-")
                                    let day = tempDateList[2]
                                    
                                    let chartData = ChartData(x: Double(temp), y: yData, date: xData)
                                    vc.chartData.append(chartData)
                                    temp += 1
                                }
                            }
                            //                            vc.setChartView()
                            vc.updateChartData()
                            vc.dataTableView.reloadData()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}
