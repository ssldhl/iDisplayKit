//
//  InitialDisplayNode.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/4/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InitialDisplayNode: ASDisplayNode {
    var coverImageNode: ASNetworkImageNode!
    let kCoverImageHeight: CGFloat = 130
    
    let imageURL: NSURL = NSURL(string: "https://d3fm2i59mvqhqg.cloudfront.net/2016-04-19T13:52:59:807Z.jpg")!
    
    override init(){
        super.init()
        
        coverImageNode = ASNetworkImageNode()
        coverImageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor()
        coverImageNode.URL = imageURL
        
        addSubnode(coverImageNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        /*coverImageNode.position = CGPointZero
         coverImageNode.sizeRange = ASRelativeSizeRangeMakeWithExactCGSize(constrainedSize.max)*/
        
        coverImageNode.preferredFrameSize = CGSizeMake(kCoverImageHeight, kCoverImageHeight)
        
        let mainStackLayoutSpec: ASStackLayoutSpec = ASStackLayoutSpec.verticalStackLayoutSpec()
        mainStackLayoutSpec.setChild(coverImageNode)
        
        return mainStackLayoutSpec
    }
}
