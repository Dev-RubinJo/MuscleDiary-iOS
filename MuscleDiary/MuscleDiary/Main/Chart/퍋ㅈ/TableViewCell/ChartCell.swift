//
//  ChartCell.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/07.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import SnapKit

class ChartCell: UITableViewCell {
    var chart: ChartData?
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "74KG"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020년 5월 9일"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.addSubview(self.weightLabel)
        self.addSubview(self.dateLabel)
        
        self.weightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(10)
//            make.bottom.equalTo(self.dateLabel.snp.top).offset(10)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.left.equalTo(10)
        }
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
