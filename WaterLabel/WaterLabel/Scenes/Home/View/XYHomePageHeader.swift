//
//  XTHomePageHeader.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/10/3.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class XYHomePageHeader: UICollectionReusableView {
    var viewpager:SDCycleScrollView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        viewpager = SDCycleScrollView(frame: bounds, delegate: nil, placeholderImage: UIImage(named: "bannerPlaceHolder"))
        viewpager.autoScrollTimeInterval = 4
        
        self.addSubview(viewpager)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
