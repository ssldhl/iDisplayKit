//
//  InitialDisplayNode.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/4/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InitialDisplayNode: ASDisplayNode{
    var coverImageNode: ASNetworkImageNode = ASNetworkImageNode()
    var profilePictureNode: ASNetworkImageNode = ASNetworkImageNode()
    
    var searchIcon: ASImageNode = ASImageNode()
    var addNewIcon: ASImageNode = ASImageNode()
    var newImagePost: ASImageNode = ASImageNode()
    var newVideoPost: ASImageNode = ASImageNode()
    
    var currentUserName: ASTextNode = ASTextNode()
    var newPostLabel: ASTextNode = ASTextNode()
    
    let kCoverImageHeight: CGFloat = 130
    let kProfilePictureHeight: CGFloat = 50
    
    let coverImageURL: NSURL = NSURL(string: "https://d3fm2i59mvqhqg.cloudfront.net/2016-04-19T13:52:59:807Z.jpg")!
    let profilePictureURL: NSURL = NSURL(string: "https://d3fm2i59mvqhqg.cloudfront.net/2016-04-15T13:13:18:932Z.jpg")!
    
    override init(){
        super.init()
        
        setup()
        updateLabels()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let cover: ASLayoutSpec = coverStack(constrainedSize)
        
        let mainStackLayoutSpec: ASStackLayoutSpec = ASStackLayoutSpec.verticalStackLayoutSpec()
        mainStackLayoutSpec.setChildren([cover])
        
        return mainStackLayoutSpec
    }
    
//    MARK: cover stack
    func coverStack(constrainedSize: ASSizeRange)->ASLayoutSpec{
        coverImageNode.preferredFrameSize = CGSizeMake(constrainedSize.max.width, kCoverImageHeight)
        profilePictureNode.preferredFrameSize = CGSizeMake(kProfilePictureHeight, kProfilePictureHeight)
        
        let coverTop: ASDisplayNode = ASDisplayNode()
        profilePictureNode.position = CGPointMake(0, 10)
        coverTop.addSubnode(profilePictureNode)
        
        let searchLayoutSpec: ASStackLayoutSpec = ASStackLayoutSpec.horizontalStackLayoutSpec()
        searchLayoutSpec.layoutPosition = CGPointMake(50, 20)
        searchLayoutSpec.setChildren([searchIcon, addNewIcon])
        
        let coverImageBackground: ASBackgroundLayoutSpec = ASBackgroundLayoutSpec(child: coverTop, background: coverImageNode)
        return coverImageBackground
    }
    
//    MARK: SuperClass
    override func displayWillStart() {
        super.displayWillStart()
        fetchData()
    }
    
    override func fetchData() {
        super.fetchData()
        loadImage()
    }
    
//    MARK: Private
    func setup(){
        searchIcon.image = UIImage(named: "Search")
        searchIcon.preferredFrameSize = CGSizeMake(22, 22)
        
        addNewIcon.image = UIImage(named: "New")
        addNewIcon.preferredFrameSize = CGSizeMake(22, 22)
        
        newImagePost.image = UIImage(named: "ImagePost")
        newImagePost.preferredFrameSize = CGSizeMake(25, 25)
        
        newVideoPost.image = UIImage(named: "VideoPost")
        newVideoPost.preferredFrameSize = CGSizeMake(25, 25)
        
        setDefaultImageProperties([coverImageNode, profilePictureNode, searchIcon, addNewIcon, newImagePost, newVideoPost])
        
        currentUserName.maximumNumberOfLines = 1
        currentUserName.alignSelf = ASStackLayoutAlignSelf.Start
        currentUserName.flexGrow = true
        currentUserName.layerBacked = true
        
        newPostLabel.maximumNumberOfLines = 1
        newPostLabel.alignSelf = ASStackLayoutAlignSelf.Start
        newPostLabel.flexGrow = true
        newPostLabel.layerBacked = true
        
        addSubnode(coverImageNode)
        addSubnode(searchIcon)
        addSubnode(addNewIcon)
        addSubnode(newImagePost)
        addSubnode(newVideoPost)
        
        addSubnode(newPostLabel)
    }
    
    func updateLabels(){
        currentUserName.attributedString = NSAttributedString(string: "User Name", attributes: nil)
        newPostLabel.attributedString = NSAttributedString(string: "What's happening?", attributes: nil)
    }
    
    func setDefaultImageProperties(images: [ASImageNode]){
        for image in images{
            image.placeholderEnabled = true
            image.placeholderColor = ASDisplayNodeDefaultPlaceholderColor()
            image.contentMode = UIViewContentMode.ScaleToFill
            image.placeholderFadeDuration = 0.0
            image.layerBacked = true
        }
    }
    
    func loadImage(){
        coverImageNode.setURL(coverImageURL, resetToDefault: true)
        profilePictureNode.setURL(profilePictureURL, resetToDefault: true)
    }
}
