import Foundation
import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article?
    
    let header = ArticleHeaderView()
    let content = ArticleContentView()
    var comments: CommentsViewController!
    var scrollView: UIScrollView!
    
    required init(provider: ServiceProviderType, article: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = article
        self.comments = CommentsViewController(provider: provider, articleSlug: article.slug!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.scrollView = UIScrollView(frame: view.frame)
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        
        setupHeaderView()
        setupContentView()
        setupCommentView()
        self.view.addSubview(scrollView)
    }
    
    func setupHeaderView() {
        self.scrollView.addSubview(header)
        if let avatarUrl = article?.author?.image, let username = article?.author?.username, let createdAt = article?.createdAt {
            header.update(avatarUrl: avatarUrl, username: username, createdAt: createdAt)
        }
        self.header.snp.makeConstraints { make -> Void in
            make.top.equalTo(scrollView.snp.top)
            make.height.equalTo(70)
            make.left.equalTo(20)
        }
    }
    
    func setupContentView() {
        self.scrollView.addSubview(content)
        if let title = article?.title, let description = article?.descriptionValue {
            content.update(title: title, description: description)
        }
        self.content.snp.makeConstraints { make -> Void in
            make.top.equalTo(header.snp.bottom)
            make.left.equalTo(header)
        }
    }
    
    func setupCommentView() {
        self.scrollView.addSubview(comments.view)
        self.comments.view.snp.makeConstraints { make -> Void in
            make.top.equalTo(content.snp.bottom)
            make.left.equalTo(header)
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
