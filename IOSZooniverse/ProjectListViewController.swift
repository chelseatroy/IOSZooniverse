import UIKit

class ProjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var objects = NSMutableArray()
    var indicator = UIActivityIndicatorView()

    var tableView: UITableView = UITableView()
    var apiClient: ApiClient!

    convenience init(apiClient: ApiClient) {
        self.init()

        self.apiClient = apiClient
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = CGRect.zero;
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDictionary = ["table": tableView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDictionary))

        self.indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.indicator.center = self.view.center
        self.view.addSubview(indicator)
        self.indicator.startAnimating()

        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(ProjectListViewController.displayProjects), name: "didFetchProjects", object: nil)

        apiClient.getProjects()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            //self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func displayProjects(notification: NSNotification) {
        print("this is called")
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true

            if let projects = notification.object as? [Project] {
                for project in projects {
                    self.insertNewObject(project)
                }
            }
        }

    }


func insertNewObject(sender: AnyObject) {
    objects.insertObject(sender, atIndex: 0)
    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
}

// MARK: - Table View

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

    let object = objects[indexPath.row] as! Project
    cell.textLabel!.text = object.title
    return cell
}

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You selected cell #\(indexPath.row)!")
}

}


