import XCTest

@testable import ChuckClass

final class HomeServiceTests: XCTestCase {
    var homeService: HomeService!
    
    override func setUpWithError() throws {
        homeService = HomeService()
    }
    
    override func tearDownWithError() throws {
        homeService = nil
    }
    
    func testGetHomeSuccess() {
        let expected = self.expectation(description: "fetch categories")
        
        homeService.getHome { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Success nao pode ser nil")
                XCTAssertGreaterThan(success.count, 0)
                expected.fulfill()
            case .failure:
                XCTFail("a request nao pode cair no caso de failure")
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetHomeFailure() {
        let expected = self.expectation(description: "fetch categories failure")
        
        homeService.getHome { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Success nao pode ser nil")
                XCTAssertGreaterThan(success.count, 0)
                expected.fulfill()
            case .failure:
                XCTFail("a request nao pode cair no caso de failure")
            }
        }
        
        waitForExpectations(timeout: 10)
        
    }
}
