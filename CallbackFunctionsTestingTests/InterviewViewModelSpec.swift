import Foundation
import Quick
import Nimble
import ObjectMapper

@testable import CallbackFunctionsTesting

class MockInterviewService: InterviewsServiceProtocol {
    var isMyInterviewCalled: Bool = false
    var isInterviewCalled: Bool = false
    var myInterviews: [Interview] = []
    var interviews: [Interview] = []

    func getMyInterviews(_ completion: @escaping ([Interview]) -> Void) {
        isMyInterviewCalled = true
        completion(myInterviews)
    }

    func getInterviews(_ completion: @escaping ([Interview]) -> Void) {
        isInterviewCalled = true
        completion(interviews)
    }
}

class InterviewViewModelSpec: QuickSpec {
    override func spec() {

        describe("Interview View Model") {
            context("getInterviews") {
                context("should call the interview service to get user interviews") {
                    it("should not call all interviews when my interviews is not empty") {
                        let map = Map(mappingType: ObjectMapper.MappingType.fromJSON,
                                      JSON: ["first_name": "firstName", "last_name": "lastName", "role_id": "1"])
                        let interview = Interview(map: map)!

                        let mockInterviewService = MockInterviewService()
                        mockInterviewService.myInterviews = [interview]
                        let viewModel = InterviewsViewModel(interviewsService: mockInterviewService)

                        viewModel.refreshInterviews({})

                        expect(mockInterviewService.isMyInterviewCalled).to(be(true))
                        expect(mockInterviewService.isInterviewCalled).to(be(false))

                        expect(viewModel.interviews.count).to(equal(1))
                        expect(viewModel.interviews[0]).to(beIdenticalTo(interview))
                    }

                    it("should call all interviews when my interviews is empty") {
                        let map = Map(mappingType: ObjectMapper.MappingType.fromJSON,
                                      JSON: ["first_name": "firstName", "last_name": "lastName", "role_id": "1"])
                        let interview = Interview(map: map)!

                        let mockInterviewService = MockInterviewService()
                        mockInterviewService.myInterviews = []
                        mockInterviewService.interviews = [interview]
                        let viewModel = InterviewsViewModel(interviewsService: mockInterviewService)

                        viewModel.refreshInterviews({})

                        expect(mockInterviewService.isMyInterviewCalled).to(be(true))
                        expect(mockInterviewService.isInterviewCalled).to(be(true))
                        
                        expect(viewModel.interviews.count).to(equal(1))
                        expect(viewModel.interviews[0]).to(beIdenticalTo(interview))
                    }
                }
            }

            context("total Interviews") {
                it("should return the number of interviews") {
                    let map = Map(mappingType: ObjectMapper.MappingType.fromJSON,
                                  JSON: ["first_name": "firstName", "last_name": "lastName", "role_id": "1"])
                    let interview = Interview(map: map)!
                    let viewModel = InterviewsViewModel(interviewsService: MockInterviewService())

                    viewModel.interviews = []
                    expect(viewModel.interviews.count).to(equal(0))

                    viewModel.interviews = [interview, interview]
                    expect(viewModel.interviews.count).to(equal(2))
                }
            }

            context("interview name") {
                it("should append the first name and last name with space") {
                    let interview = Interview(firstName: "firstName", lastName: "lastName")
                    let viewModel = InterviewsViewModel(interviewsService: MockInterviewService())

                    viewModel.interviews = [interview]
                    expect(viewModel.interviewName(at: 0)).to(equal("firstName lastName"))
                }
            }

        }
    }
}


