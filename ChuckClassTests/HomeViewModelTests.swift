import XCTest
@testable import ChuckClass

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockService: MockHomeService!
    
    override func setUpWithError() throws {
        mockService = MockHomeService()
        viewModel = HomeViewModel(service: mockService)
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
    }
    
    func testFetchRequestSuccess() {
        var list: [String] = ["opcao1", "opcao2"]
        mockService.result = .success(list)
        viewModel.fetchRequest()
        
        XCTAssertEqual(viewModel.numberOfRowsInSection, list.count)
        XCTAssertEqual(viewModel.loadCurrentCategory(indexPath: IndexPath(row: 0, section: 0)), list[0])
    }
}

final class MockHomeService: HomeServiceDelegate {
    var result: Result<[String], Error> = .success([])
    func getHome(completion: @escaping (Result<[String], Error>) -> Void) {
        completion(result)
    }
    
    
}
