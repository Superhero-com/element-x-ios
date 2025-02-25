//
// Copyright 2022 New Vector Ltd
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

import Combine
import SwiftUI

typealias EmojiPickerScreenViewModelType = StateStoreViewModel<EmojiPickerScreenViewState, EmojiPickerScreenViewAction>

class EmojiPickerScreenViewModel: EmojiPickerScreenViewModelType, EmojiPickerScreenViewModelProtocol {
    private var actionsSubject: PassthroughSubject<EmojiPickerScreenViewModelAction, Never> = .init()
    
    var actions: AnyPublisher<EmojiPickerScreenViewModelAction, Never> {
        actionsSubject.eraseToAnyPublisher()
    }
    
    private let emojiProvider: EmojiProviderProtocol
    
    init(emojiProvider: EmojiProviderProtocol) {
        let initialViewState = EmojiPickerScreenViewState(categories: [])
        self.emojiProvider = emojiProvider
        super.init(initialViewState: initialViewState)
        loadEmojis()
    }
    
    // MARK: - Public
    
    override func process(viewAction: EmojiPickerScreenViewAction) {
        switch viewAction {
        case let .search(searchString: searchString):
            Task {
                let categories = await emojiProvider.getCategories(searchString: searchString)
                state.categories = convert(emojiCategories: categories)
            }
        case let .emojiTapped(emoji: emoji):
            actionsSubject.send(.emojiSelected(emoji: emoji.value))
        case .dismiss:
            actionsSubject.send(.dismiss)
        }
    }
    
    // MARK: - Private

    private func loadEmojis() {
        Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            let categories = await self.emojiProvider.getCategories(searchString: nil)
            self.state.categories = convert(emojiCategories: categories)
        }
    }
    
    private func convert(emojiCategories: [EmojiCategory]) -> [EmojiPickerEmojiCategoryViewData] {
        emojiCategories.compactMap { emojiCategory in
            
            let emojisViewData: [EmojiPickerEmojiViewData] = emojiCategory.emojis.compactMap { emojiItem in
                EmojiPickerEmojiViewData(id: emojiItem.id, value: emojiItem.unicode)
            }
            
            return EmojiPickerEmojiCategoryViewData(id: emojiCategory.id, emojis: emojisViewData)
        }
    }
}
