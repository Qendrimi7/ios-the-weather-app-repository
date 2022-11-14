//
//  HomeTests.swift
//  The Weather AppTests
//
//  Created by Qendrim Mjeku on 14.11.22.
//

import XCTest

@testable import The_Weather_App
final class HomeTests: XCTestCase {

    var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_base_URL() {
        XCTAssertEqual(Environment[.API_BASE_URL].absoluteString, "https://api.openweathermap.org/data/2.5")
    }
    
    func test_section_is_empty() {
        viewModel.sections = []
        XCTAssertTrue(viewModel.isSectionEmpty())
    }
    
    func test_section_is_not_empty() {
        viewModel.appendSections(response: [APIResponseObject.WeatherDataResponse(cod: nil, message: nil, cnt: nil, list: nil, city: nil)])
        XCTAssertTrue(!viewModel.isSectionEmpty())
    }
    
    func test_number_of_rows_in_sections() {
        XCTAssertTrue(viewModel.numberOfRowsInSection() == 1)
    }

    // MARK: -  We can test other case like  getTempMax, getImageTemperatureName, getDayName, getCountryNameOrCity etc
}

