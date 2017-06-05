import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import CallbackFunctionsTesting

class InterviewServiceSpec: QuickSpec {

    override func spec() {
        describe("Interview service spec") {
            context("get my interviews") {
                it("should return items") {
                    let interviewService = InterviewsService()
                    let stubbedInterviews = [["first_name": "one", "last_name": "two"], ["first_name": "two", "last_name": "two"]]

                    let data = NSKeyedArchiver.archivedData(withRootObject: stubbedInterviews)

                    stub(condition: isHost("10.134.23.127")) { _ in
                        return OHHTTPStubsResponse(data: data, statusCode: 200,
                                                   headers: nil)
                    }

                    var actualInterviews: [Interview]?
                    interviewService.getMyInterviews({interviews in actualInterviews = interviews})

                    expect(actualInterviews?.count).to(beNil())
                }
            }

        }
    }
}
