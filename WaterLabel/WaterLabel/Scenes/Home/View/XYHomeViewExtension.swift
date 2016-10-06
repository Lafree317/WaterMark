//
//  XTHomeViewExtension.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/10/3.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
let XYHomeCellId = "XYHomeCell"
let XYHomeHeaderViewId = "XYHomePageHeader"
let XYHomeCellWidth:CGFloat = screenWidth/2
let XYHomeCellHeith:CGFloat = screenWidth/2

extension XYHomeVC{
    func setUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), collectionViewLayout: layout)
        collectionView.register(XYHomeCell.self, forCellWithReuseIdentifier: XYHomeCellId)
        collectionView.register(XYHomePageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: XYHomeHeaderViewId)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }

}
