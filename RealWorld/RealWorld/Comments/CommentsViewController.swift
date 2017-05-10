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
 
    let disposeBag = DisposeBag()
    var viewModel: CommentsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(provider: ServiceProviderType, articleSlug: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = CommentsViewModel(provider: provider, articleSlug: articleSlug)
        viewModel.fetchComments()
        viewModel.comments$.subscribe(onNext: { comments in
            let views = comments?.map {
                self.addComment(comment: $0)
            }
            views?.reduce(self.view, {
                self.addConstraints(view: $1.0, label: $1.1, previousView: $0!)
                return $1.0
            })
        })
        .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComment(comment: Comment) -> (UIView, UILabel) {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        self.view.addSubview(view1)
        
        let label = UILabel()
        label.text = comment.body
        view1.addSubview(label)
        
        return (view1, label)
    }
    
    func addConstraints(view: UIView, label: UILabel, previousView: UIView) {
        view.snp.makeConstraints { make -> Void in
            make.top.equalTo(previousView.snp.bottom)
            make.left.equalTo(previousView)
            make.height.equalTo(100)
        }
        label.snp.makeConstraints { make -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
        }
    }
    
}
