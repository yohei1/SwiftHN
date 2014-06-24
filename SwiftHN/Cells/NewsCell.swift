//
//  NewsCell.swift
//  SwiftHN
//
//  Created by Thomas Ricouard on 05/06/14.
//  Copyright (c) 2014 Thomas Ricouard. All rights reserved.
//

import UIKit
import SwiftHNLiveViews

let NewsCellsId = "newsCellId"
let NewsCellHeight: CGFloat = 110.0
let NewsCellTitleMarginConstant: CGFloat = 16.0
let NewsCellTitleFontSize: CGFloat = 16.0

@objc protocol NewsCellDelegate {
    func newsCellDidSelectButton(cell: NewsCell, actionType: NewsCellActionType)
}

class NewsCell: UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel = nil
    @IBOutlet var urlLabel : UILabel = nil
    @IBOutlet var voteLabel : BorderedButton = nil
    @IBOutlet var commentsLabel : BorderedButton = nil
    @IBOutlet var usernameLabel: BorderedButton = nil

    @IBOutlet var titleMarginConstrain: NSLayoutConstraint = nil
    
    weak var cellDelegate: NewsCellDelegate?
    
    var post: HNPost! {
        didSet{
            self.titleLabel.text = self.post.Title
            self.urlLabel.text = self.post.UrlString + " - " + self.post.TimeCreatedString
            self.voteLabel.labelText = "\(self.post.Points) votes"
            self.commentsLabel.labelText = "\(self.post.CommentCount) comments"
            self.usernameLabel.labelText = self.post.Username
            
            self.voteLabel.onButtonTouch = {(sender: UIButton) in
                self.selectedAction(.Vote)
            }
            
            self.commentsLabel.onButtonTouch = {(sender: UIButton) in
                self.selectedAction(.Comment)
            }
            
            self.usernameLabel.onButtonTouch = {(sender: UIButton) in
                self.selectedAction(.Username)
            }
        }
    }

    init(style: UITableViewCellStyle, reuseIdentifier: String!)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func selectedAction(action: NewsCellActionType) {
        self.cellDelegate?.newsCellDidSelectButton(self, actionType: action)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.preferredMaxLayoutWidth = self.contentView.bounds.width - (self.titleMarginConstrain.constant * 2)
    }
    
}
