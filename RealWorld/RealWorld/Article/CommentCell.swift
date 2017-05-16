//
//  CommentCell.swift
//  RealWorld
//
//  Created by Thomas Sattlecker on 15/05/2017.
//  Copyright © 2017 Thomas Sattlecker. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    
    var commentLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(comment: Comment) {
        commentLabel.text = comment.body
    }
    
    func setupTextLabel() {
        self.commentLabel = UILabel()
        self.addSubview(self.commentLabel)
        self.commentLabel.snp.makeConstraints { make -> Void in
            make.height.equalTo(70)
            make.left.equalTo(20)
        }
    }
    
}
