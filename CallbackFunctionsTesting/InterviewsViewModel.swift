import Foundation
import UIKit

class InterviewsViewModel {

    let interviewsService: InterviewsServiceProtocol
    var interviews: [Interview]
    var completionBlock: ((Void) -> (Void))?

    deinit {
        print("deinit: InterviewsViewModel")
    }

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

    func refreshInterviews() {
        interviewsService.getMyInterviews({myInterviews in

            if myInterviews.isEmpty {
                self.interviewsService.getInterviews({allInterviews in
                    self.interviews = allInterviews
                })
            } else {
                self.interviews = myInterviews
            }
            self.completionBlock!()
        })

    }
}
