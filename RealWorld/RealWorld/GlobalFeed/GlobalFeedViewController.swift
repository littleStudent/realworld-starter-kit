import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class GlobalFeedViewController: UIViewController, UITableViewDelegate {
    
    struct Constants {
        static let title = "Global"
        static let cellIdentifier = "ArticleCell"
        static let rowHeight: CGFloat = 200
    }
    
    var refreshControl: UIRefreshControl!
    var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let viewModel = GlobalFeedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.title
        
        setup()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    func setup() {
        setupUI()
        setupBindings()
    }
    
    func refresh() {
        viewModel.fetchArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension GlobalFeedViewController {
    func setupUI() {
        tableView = setupTableView()
        refreshControl = setupRefreshControl()
        tableView.addSubview(refreshControl)
        self.view.addSubview(tableView)
    }
    
    func setupTableView() -> UITableView {
        let newTableView = createTableView(sourceView: self.view)
        newTableView.rowHeight = Constants.rowHeight
        newTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        newTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.navigationController?.pushViewController(ArticleViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        return newTableView
    }
    
    func setupRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(GlobalFeedViewController.refresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }
}


// Reactive bindings | ViewModel - Controller
extension GlobalFeedViewController {
    
    func setupBindings() {
        bindArticles()
        bindInProgress()
    }
    
    func bindArticles() {
        viewModel.articles$.asObserver()
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: ArticleTableViewCell.self)) { index, article, cell in
                cell.article = article
            }
            .disposed(by: disposeBag)
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

