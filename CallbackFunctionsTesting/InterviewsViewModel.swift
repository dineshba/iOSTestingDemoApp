import Foundation

class InterviewsViewModel {

    let interviewsService: InterviewsServiceProtocol
    var interviews: [Interview]

    init(interviewsService: InterviewsServiceProtocol) {
        self.interviewsService = interviewsService
        self.interviews = []
    }

    func totalInterviews() -> Int {
        return interviews.count
    }

    func interviewName(at index: Int) -> String {
        let interview = interviews[index]
        return interview.firstName! + " " +  interview.lastName!
    }

    func getInterviews(_ completion: @escaping (Void) -> Void) {
        interviewsService.getMyInterviews({myInterviews in

            if myInterviews.isEmpty {
                self.interviewsService.getInterviews({allInterviews in
                    self.interviews = allInterviews
                })
            } else {
                self.interviews = myInterviews
            }
            completion()
        })

    }
}
