import XCTest
import OHHTTPStubs
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
        
        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains("https://api.chucknorris.io/jokes/categories") ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }
        
        
        homeService.getHome { result in
            switch result {
            case .success:
                XCTFail("a request nao pode cair no caso de success")
            case .failure(let error):
                XCTAssertNotNil(error)
                expected.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20)
        HTTPStubs.removeAllStubs()
        
    }
}
