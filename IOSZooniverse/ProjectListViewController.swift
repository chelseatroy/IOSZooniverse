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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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

        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(ProjectListViewController.displayProjects), name: NSNotification.Name(rawValue: "didFetchProjects"), object: nil)

        apiClient.getProjects()

        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ProjectListViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            _ = split.viewControllers
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func displayProjects(_ notification: Notification) {
        OperationQueue.main.addOperation {
//            self.projectListView.stopAnimating()

            if let projects = notification.object as? [Project] {
                for project in projects {
                    self.insertNewObject(project)
                }
            }
        }

    }


func insertNewObject(_ sender: AnyObject) {
    objects.insert(sender, at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    projectListView!.tableView.insertRows(at: [indexPath], with: .automatic)
}

// MARK: - Table View

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = projectListView!.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

    let object = objects[indexPath.row] as! Project
    cell.textLabel!.text = object.title
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You selected cell #\(indexPath.row)!")
}

}


