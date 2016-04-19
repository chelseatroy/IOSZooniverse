import XCTest

@testable import IOSZooniverse

class ProjectListViewControllerTest: IOSZooniverseTestCase {
    var subject: ProjectListViewController!
    
    override func setUp() {
        super.setUp()
        
        subject = ProjectListViewController()
        subject.view.layoutSubviews()
    }
    
    func testSomething() {
        XCTAssertEqual(1 ,1)
        XCTAssertEqual(subject.tableView.separatorStyle, UITableViewCellSeparatorStyle.None)
    }
}
