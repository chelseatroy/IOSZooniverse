import UIKit

class ProjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var projectListView: ProjectListView?
    var objects = NSMutableArray()
    var apiClient: ApiClient!

    convenience init(apiClient: ApiClient) {
        self.init(nibName: nil, bundle: nil)
        self.apiClient = apiClient
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        self.projectListView = ProjectListView()
        self.view = projectListView!.baseView
        projectListView!.tableView.delegate = self
        projectListView!.tableView.dataSource = self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(ProjectListViewController.displayProjects), name: "didFetchProjects", object: nil)

        apiClient.getProjects()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func displayProjects(notification: NSNotification) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
//            self.projectListView.stopAnimating()

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
    projectListView!.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
}

// MARK: - Table View

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = projectListView!.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

    let object = objects[indexPath.row] as! Project
    cell.textLabel!.text = object.title
    return cell
}

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You selected cell #\(indexPath.row)!")
}

}


