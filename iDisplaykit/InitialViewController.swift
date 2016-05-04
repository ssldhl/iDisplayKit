//
//  InitialViewController.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/3/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InitialViewController: ASViewController, ASTableDelegate, ASTableDataSource {
    
    let imageCategories: [String] = ["abstract", "animals", "business", "cats", "city", "food", "nightlife", "fashion", "people", "nature", "sports", "technics", "transport"]
    let tableNode: ASTableNode = ASTableNode()
    
    override init(node: ASDisplayNode) {
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Image Categories"
        
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath: NSIndexPath = tableNode.view.indexPathForSelectedRow{
            tableNode.view.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: ASTableDataSource / ASTableDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageCategories.count
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        let imageCategory: String = imageCategories[indexPath.row]
        
        let cellNodeBlock: ASCellNodeBlock = {
            let textCellNode: ASTextCellNode = ASTextCellNode()
            textCellNode.text = imageCategory.uppercaseString
            
            return textCellNode
        }
        
        return cellNodeBlock
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imageCategory: String = imageCategories[indexPath.row]
        let detailRootNode: DetailRootNode = DetailRootNode(imageCategory: imageCategory)
        let detailViewController: DetailViewController = DetailViewController(node: detailRootNode)
        detailViewController.title = imageCategory.capitalizedString
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

