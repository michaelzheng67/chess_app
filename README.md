# Vision Pro - Chess App
```
A VisionOS app that lets you play chess against a bot or your friends
```
https://github.com/michaelzheng67/chess_app/assets/82613778/0b7c3b54-645b-4a33-bda6-b196b1086afd

## Setup:
- Launch chess.xcodeproj in your xcode beta ide. Open up the VisionOS Simulator
- Launch the Chess-Engine backend:
```
# cd into the chess engine folder
source /venv/bin/active # get the dependencies in virtual env
python app.py
```
- That's it! Now you should be good to play against the bot. This app works by calling the backend through HTTP requests every time it's time for the bot to play / update the board.
