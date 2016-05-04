//
//  DetailRootNode.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/4/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DetailRootNode: ASDisplayNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    var imageCategory: String!
    
    let kImageHeight: CGFloat = 200
    
    init(imageCategory: String) {
        super.init()
        
        self.imageCategory = imageCategory
        
//        Create ASCollectionView. We don't have to add it explicitly as subnode as we will set usesImplicitHierarchyManagement to true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.backgroundColor = UIColor.whiteColor()
        
        /*
         Enable usesImplicitHierarchyManagement so the first time the layout pass of the node is happening all nodes that are referenced
         in layouts within layoutSpecThatFits: will be added automatically
         */
        DetailRootNode.setUsesImplicitHierarchyManagement(true)
    }
    
//    MARK: ASDisplayNode
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        collectionNode.position = CGPointZero
        collectionNode.sizeRange = ASRelativeSizeRangeMakeWithExactCGSize(constrainedSize.max)
        
        let staticLayoutSpec: ASStaticLayoutSpec = ASStaticLayoutSpec(children: [collectionNode])
        return staticLayoutSpec
    }
    
//    MARK: ASCollectionDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        let cellNodeBlock: ASCellNodeBlock = {
            let detailCellNode: DetailCellNode = DetailCellNode()
            detailCellNode.row = indexPath.row
            detailCellNode.imageCategory = self.imageCategory
            return detailCellNode
        }
        
        return cellNodeBlock
    }
    
    func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
        let imageSize: CGSize = CGSizeMake(CGRectGetWidth(collectionView.frame), kImageHeight)
        let sizeRange: ASSizeRange = ASSizeRangeMake(imageSize, imageSize)
        
        return sizeRange
    }
    
}
