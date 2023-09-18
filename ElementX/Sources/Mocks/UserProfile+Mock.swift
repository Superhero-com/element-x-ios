//
// Copyright 2023 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

extension UserProfileProxy {
    // Mocks
    static var mockAlice: UserProfileProxy {
        .init(userID: "@alice:superhero.com", displayName: "Alice", avatarURL: "mxc://matrix.org/UcCimidcvpFvWkPzvjXMQPHA")
    }

    static var mockBob: UserProfileProxy {
        .init(userID: "@bob:superhero.com", displayName: "Bob", avatarURL: nil)
    }

    static var mockBobby: UserProfileProxy {
        .init(userID: "@bobby:superhero.com", displayName: "Bobby", avatarURL: nil)
    }

    static var mockCharlie: UserProfileProxy {
        .init(userID: "@charlie:superhero.com", displayName: "Charlie", avatarURL: nil)
    }
    
    static var mockVerbose: UserProfileProxy {
        .init(userID: "@charlie:superhero.com", displayName: "Charlie is the best display name", avatarURL: nil)
    }
}
