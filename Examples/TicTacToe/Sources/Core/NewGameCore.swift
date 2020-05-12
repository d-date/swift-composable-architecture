import ComposableArchitecture
import GameCore
import TicTacToeCommon

public struct NewGameState: Equatable {
  public var game: GameState? = nil
  public var oPlayerName = ""
  public var xPlayerName = ""

  public init() {}
}

public enum NewGameAction: Equatable {
  case game(GameAction)
  case gameDismissed
  case letsPlayButtonTapped
  case logoutButtonTapped
  case oPlayerNameChanged(String)
  case xPlayerNameChanged(String)
}

public struct NewGameEnvironment {
  public init() {}
}

public let newGameReducer = Reducer<NewGameState, NewGameAction, NewGameEnvironment> {
  state, action, _ in
  switch action {
  case .game(.quitButtonTapped):
    state.game = nil
    return .none

  case .gameDismissed:
    state.game = nil
    return .none

  case .game:
    return .none

  case .letsPlayButtonTapped:
    state.game = GameState(
      oPlayerName: state.oPlayerName,
      xPlayerName: state.xPlayerName
    )
    return .none

  case .logoutButtonTapped:
    return .none

  case let .oPlayerNameChanged(name):
    state.oPlayerName = name
    return .none

  case let .xPlayerNameChanged(name):
    state.xPlayerName = name
    return .none
  }
}

public let newGameFeatureReducer = Reducer.combine(
  newGameReducer,
  gameReducer.pullback(
    state: OptionalPath(\.game),
    action: /NewGameAction.game,
    environment: { _ in GameEnvironment() }
  )
)
