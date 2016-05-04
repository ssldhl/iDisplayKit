//
//  DetailCellNode.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/4/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DetailCellNode: ASCellNode {
    var row: Int!
    var imageCategory: String!
    var imageNode: ASNetworkImageNode!
    
    override init(){
        super.init()
        
        imageNode = ASNetworkImageNode()
        imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor()
        addSubnode(imageNode)
    }
    
//    MARK: ASDisplayNode
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.position = CGPointZero
        imageNode.sizeRange = ASRelativeSizeRangeMakeWithExactCGSize(constrainedSize.max)
        
        let layoutSpec: ASStaticLayoutSpec = ASStaticLayoutSpec(children: [imageNode])
        return layoutSpec
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        /*
         In general set URL of ASNetworkImageNode as soon as possible. Ideally in init or a
        view model setter method.
        In this case as we need to know the size of the node the url is set in layoutDidFinish so
        we have the calculatedSize available
         */
        imageNode.URL = imageURL()
    }
    
//    MARK: Image
    func imageURL()->NSURL{
        let imageSize: CGSize = calculatedSize
        let imageWidth: Int = Int(imageSize.width)
        let imageHeight: Int = Int(imageSize.height)
        let imageURLString: String = "http://lorempixel.com/\(imageWidth)/\(imageHeight)/\(imageCategory)/\(row)"
        let imageURL: NSURL = NSURL(string: imageURLString)!
        return imageURL
    }
    
}
