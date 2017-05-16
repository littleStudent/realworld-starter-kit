import Foundation
import UIKit
import RxSwift
import RxDataSources

class ArticleViewController: UIViewController, UITableViewDelegate {
    
    struct Constants {
        static let headerCellIdentifier = "HeaderCell"
        static let contentCellIdentifier = "ContentCell"
        static let commentCellIdentifier = "CommentCell"
        static let rowHeight: CGFloat = 200
    }
    
    let disposeBag = DisposeBag()
    var article: Article?
    var viewModel: ArticleViewModel
    
    var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    required init(provider: ServiceProviderType, article: Article) {
        self.article = article
        self.viewModel = ArticleViewModel(provider: provider, article: article)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        refresh()
    }
    
    func refresh() {
        viewModel.fetchComments()
    }
    
    func setup() {
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension ArticleViewController {
    func setupUI() {
        tableView = setupTableView()
        refreshControl = setupRefreshControl()
        tableView.addSubview(refreshControl)
        self.view.addSubview(tableView)
    }
    
    func setupTableView() -> UITableView {
        let newTableView = createTableView(sourceView: self.view)
        newTableView.rowHeight = UITableViewAutomaticDimension
        newTableView.estimatedRowHeight = 140
        newTableView.register(ArticleHeaderCell.self, forCellReuseIdentifier: Constants.headerCellIdentifier)
        newTableView.register(ArticleContentCell.self, forCellReuseIdentifier: Constants.contentCellIdentifier)
        newTableView.register(CommentCell.self, forCellReuseIdentifier: Constants.commentCellIdentifier)
        
        return newTableView
    }
    
    func setupRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ArticleViewController.refresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }
}

extension ArticleViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        case 1:
            return 100
        case 2:
            return 50
        default:
            return 50
        }
    }
}


// Reactive bindings | ViewModel - Controller
extension ArticleViewController {
    
    func setupBindings() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<MultipleSectionModel>()
        
        skinTableViewDataSource(dataSource)
        
        Observable.combineLatest(viewModel.comments$, viewModel.article$) { ($0, $1) }
            .map {
                return [
                    .ArticleHeaderSection(title: "", items: [.ArticleHeaderSectionItem(avatarUrl: $0.1.author?.image, username: $0.1.author?.username, createdAt: $0.1.createdAt)]),
                    .ArticleBodySection(title: "", items: [.ArticleBodySectionItem(title: $0.1.title!, text: $0.1.body!)]),
                    .CommentSection(title: "", items: ($0.0 ?? []).map { .CommentSectionItem(comment: $0) })
                ] as [MultipleSectionModel]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        bindInProgress()
    }
    
    func skinTableViewDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<MultipleSectionModel>) {
        dataSource.configureCell = { (dataSource, table, idxPath, _) in
            switch dataSource[idxPath] {
            case let .ArticleHeaderSectionItem(avatarUrl, username, createdAt):
                let cell: ArticleHeaderCell = table.dequeueReusableCell(withIdentifier: Constants.headerCellIdentifier) as! ArticleHeaderCell
                cell.update(avatarUrl: avatarUrl, username: username, createdAt: createdAt)
                return cell
                
            case let .ArticleBodySectionItem(title, text):
                let cell: ArticleContentCell = table.dequeueReusableCell(withIdentifier: Constants.contentCellIdentifier) as! ArticleContentCell
                cell.update(title: title, description: text)
                return cell
                
            case let .CommentSectionItem(comment):
                let cell: CommentCell = table.dequeueReusableCell(withIdentifier: Constants.commentCellIdentifier) as! CommentCell
                cell.update(comment: comment)                
                return cell
            }
        }
        
//        dataSource.titleForHeaderInSection = { dataSource, index in
//            let section = dataSource[index]
//            
//            return section.title
//        }
    }
    
    func bindInProgress() {
        viewModel.requestInProgress$.asObserver()
            .subscribe(onNext: { inProgress in
                if inProgress {
                    self.refreshControl.beginRefreshing()
                } else {
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

enum MultipleSectionModel {
    case ArticleHeaderSection(title: String, items: [SectionItem])
    case ArticleBodySection(title: String, items: [SectionItem])
    case CommentSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case ArticleHeaderSectionItem(avatarUrl: String?, username: String?, createdAt: Date?)
    case ArticleBodySectionItem(title: String, text: String)
    case CommentSectionItem(comment: Comment)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .ArticleHeaderSection(title: _, items: let items):
            return items.map {$0}
        case .ArticleBodySection(title: _, items: let items):
            return items.map {$0}
        case .CommentSection(title: _, items: let items):
            return items.map {$0}
        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .ArticleHeaderSection(title: title, items: _):
            self = .ArticleHeaderSection(title: title, items: items)
        case let .ArticleBodySection(title, _):
            self = .ArticleBodySection(title: title, items: items)
        case let .CommentSection(title, _):
            self = .CommentSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .ArticleHeaderSection(title: let title, items: _):
            return title
        case .ArticleBodySection(title: let title, items: _):
            return title
        case .CommentSection(title: let title, items: _):
            return title
        }
    }
}
