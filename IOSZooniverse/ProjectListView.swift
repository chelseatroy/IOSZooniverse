import Foundation
import UIKit

class ProjectListView {
    var baseView = UIView()
//    var indicator = UIActivityIndicatorView()
    var tableView: UITableView = UITableView()

    init() {
        tableView.frame = CGRect.zero;
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .None
        baseView.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDictionary = ["table": tableView]
        baseView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDictionary))
        baseView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDictionary))

//        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
//        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        indicator.center = self.baseView.center
//        baseView.addSubview(indicator)
//        indicator.startAnimating()
    }

    func stopAnimating() {
//        indicator.stopAnimating()
//        indicator.hidesWhenStopped = true
    }
}
