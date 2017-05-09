//
//  CommentsViewController.swift
//  RealWorld
//
//  Created by Thomas Sattlecker on 06/05/2017.
//  Copyright © 2017 Thomas Sattlecker. All rights reserved.
//

import Foundation
import UIKit

class CommentsViewController: UIViewController {
 
    var commentsLabel = UILabel()
    
    var viewModel: CommentsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(commentsLabel)
        commentsLabel.text = "Comments"
        self.commentsLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
        }
    }
    
    init(provider: ServiceProviderType, articleSlug: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = CommentsViewModel(provider: provider, articleSlug: articleSlug)
        viewModel.fetchComments()
        viewModel.comments$.subscribe(onNext: { comments in
            print(comments)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
