import Foundation
import UIKit

class ProjectListView {
    var baseView = UIView()
//    var indicator = UIActivityIndicatorView()
    var tableView: UITableView = UITableView()

    init() {
        tableView.frame = CGRect.zero;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        baseView.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDictionary = ["table": tableView]
        baseView.addConstraints(NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDictionary))
        baseView.addConstraints(NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDictionary))

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
