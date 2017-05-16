import UIKit

func createTableView(sourceView: UIView) -> UITableView {
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    let displayWidth: CGFloat = sourceView.frame.width
    let displayHeight: CGFloat = sourceView.frame.height
    return UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight), style: .plain)
}
