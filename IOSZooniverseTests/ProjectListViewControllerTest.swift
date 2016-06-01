import XCTest

@testable import IOSZooniverse

class ProjectListViewControllerTest: IOSZooniverseTestCase {
    var subject: ProjectListViewController!
    
    override func setUp() {
        super.setUp()
        
        subject = ProjectListViewController(apiClient: ApiClient())
        subject.view.layoutSubviews()
    }
    
    func testSomething() {
        XCTAssertEqual(subject.tableView.separatorStyle, UITableViewCellSeparatorStyle.None)
    }
}
