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
        
        InitialDisplayNode.setUsesImplicitHierarchyManagement(true)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        coverImageNode = ASNetworkImageNode()
        coverImageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor()
        coverImageNode.URL = imageURL
        coverImageNode.preferredFrameSize = CGSizeMake(constrainedSize.max.width, kCoverImageHeight)
        
        let mainStackLayoutSpec: ASStackLayoutSpec = ASStackLayoutSpec.verticalStackLayoutSpec()
        mainStackLayoutSpec.setChildren([coverImageNode])
        
        return mainStackLayoutSpec
    }
}
