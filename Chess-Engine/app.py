from flask import Flask, request
import chess
import chess.engine
import threading
app = Flask(__name__)

# keep the board in a 1d array as a global variable
STOCKFISH_PATH = "./stockfish/stockfish-macos-x86-64"
board = chess.Board()
board_lock = threading.Lock()
pawntable = [
    0, 0, 0, 0, 0, 0, 0, 0,
    5, 10, 10, -20, -20, 10, 10, 5,
    5, -5, -10, 0, 0, -10, -5, 5,
    0, 0, 0, 20, 20, 0, 0, 0,
    5, 5, 10, 25, 25, 10, 5, 5,
    10, 10, 20, 30, 30, 20, 10, 10,
    50, 50, 50, 50, 50, 50, 50, 50,
    0, 0, 0, 0, 0, 0, 0, 0]

knightstable = [
    -50, -40, -30, -30, -30, -30, -40, -50,
    -40, -20, 0, 5, 5, 0, -20, -40,
    -30, 5, 10, 15, 15, 10, 5, -30,
    -30, 0, 15, 20, 20, 15, 0, -30,
    -30, 5, 15, 20, 20, 15, 5, -30,
    -30, 0, 10, 15, 15, 10, 0, -30,
    -40, -20, 0, 0, 0, 0, -20, -40,
    -50, -40, -30, -30, -30, -30, -40, -50]
bishopstable = [
    -20, -10, -10, -10, -10, -10, -10, -20,
    -10, 5, 0, 0, 0, 0, 5, -10,
    -10, 10, 10, 10, 10, 10, 10, -10,
    -10, 0, 10, 10, 10, 10, 0, -10,
    -10, 5, 5, 10, 10, 5, 5, -10,
    -10, 0, 5, 10, 10, 5, 0, -10,
    -10, 0, 0, 0, 0, 0, 0, -10,
    -20, -10, -10, -10, -10, -10, -10, -20]
rookstable = [
    0, 0, 0, 5, 5, 0, 0, 0,
    -5, 0, 0, 0, 0, 0, 0, -5,
    -5, 0, 0, 0, 0, 0, 0, -5,
    -5, 0, 0, 0, 0, 0, 0, -5,
    -5, 0, 0, 0, 0, 0, 0, -5,
    -5, 0, 0, 0, 0, 0, 0, -5,
    5, 10, 10, 10, 10, 10, 10, 5,
    0, 0, 0, 0, 0, 0, 0, 0]
queenstable = [
    -20, -10, -10, -5, -5, -10, -10, -20,
    -10, 0, 0, 0, 0, 0, 0, -10,
    -10, 5, 5, 5, 5, 5, 0, -10,
    0, 0, 5, 5, 5, 5, 0, -5,
    -5, 0, 5, 5, 5, 5, 0, -5,
    -10, 0, 5, 5, 5, 5, 0, -10,
    -10, 0, 0, 0, 0, 0, 0, -10,
    -20, -10, -10, -5, -5, -10, -10, -20]
kingstable = [
    20, 30, 10, 0, 0, 10, 30, 20,
    20, 20, 0, 0, 0, 0, 20, 20,
    -10, -20, -20, -20, -20, -20, -20, -10,
    -20, -30, -30, -40, -40, -30, -30, -20,
    -30, -40, -40, -50, -50, -40, -40, -30,
    -30, -40, -40, -50, -50, -40, -40, -30,
    -30, -40, -40, -50, -50, -40, -40, -30,
    -30, -40, -40, -50, -50, -40, -40, -30]


@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route("/post-board", methods=["POST"])
def post_board():
    with board_lock:
        print("POST REQUEST RECEIVED")
        fen_string = request.json["board"] + " b" # we organize our data from up to down but traditionally
        difficulty = request.json["difficulty"] # depth of minmax algorithm
        # its supposed to go from down to up, so we reverse it
        # fen_string = "/".join(reversed(fen_string.split("/"))) + " b"
        print("input string = " + fen_string)
        print("difficulty = " + str(difficulty))
        global board 

    
        board = chess.Board(fen_string)

        # Print the board
        print(board)
        
        def evaluate_board():
            if board.is_checkmate():
                if board.turn:
                    return -9999
                else:
                    return 9999
            if board.is_stalemate():
                return 0
            if board.is_insufficient_material():
                return 0

            wp = len(board.pieces(chess.PAWN, chess.WHITE))
            bp = len(board.pieces(chess.PAWN, chess.BLACK))
            wn = len(board.pieces(chess.KNIGHT, chess.WHITE))
            bn = len(board.pieces(chess.KNIGHT, chess.BLACK))
            wb = len(board.pieces(chess.BISHOP, chess.WHITE))
            bb = len(board.pieces(chess.BISHOP, chess.BLACK))
            wr = len(board.pieces(chess.ROOK, chess.WHITE))
            br = len(board.pieces(chess.ROOK, chess.BLACK))
            wq = len(board.pieces(chess.QUEEN, chess.WHITE))
            bq = len(board.pieces(chess.QUEEN, chess.BLACK))

            material = 100 * (wp - bp) + 320 * (wn - bn) + 330 * (wb - bb) + 500 * (wr - br) + 900 * (wq - bq)

            pawnsq = sum([pawntable[i] for i in board.pieces(chess.PAWN, chess.WHITE)])
            pawnsq = pawnsq + sum([-pawntable[chess.square_mirror(i)]
                                for i in board.pieces(chess.PAWN, chess.BLACK)])
            knightsq = sum([knightstable[i] for i in board.pieces(chess.KNIGHT, chess.WHITE)])
            knightsq = knightsq + sum([-knightstable[chess.square_mirror(i)]
                                    for i in board.pieces(chess.KNIGHT, chess.BLACK)])
            bishopsq = sum([bishopstable[i] for i in board.pieces(chess.BISHOP, chess.WHITE)])
            bishopsq = bishopsq + sum([-bishopstable[chess.square_mirror(i)]
                                    for i in board.pieces(chess.BISHOP, chess.BLACK)])
            rooksq = sum([rookstable[i] for i in board.pieces(chess.ROOK, chess.WHITE)])
            rooksq = rooksq + sum([-rookstable[chess.square_mirror(i)]
                                for i in board.pieces(chess.ROOK, chess.BLACK)])
            queensq = sum([queenstable[i] for i in board.pieces(chess.QUEEN, chess.WHITE)])
            queensq = queensq + sum([-queenstable[chess.square_mirror(i)]
                                    for i in board.pieces(chess.QUEEN, chess.BLACK)])
            kingsq = sum([kingstable[i] for i in board.pieces(chess.KING, chess.WHITE)])
            kingsq = kingsq + sum([-kingstable[chess.square_mirror(i)]
                                for i in board.pieces(chess.KING, chess.BLACK)])

            eval = material + pawnsq + knightsq + bishopsq + rooksq + queensq + kingsq
            if board.turn:
                return eval
            else:
                return -eval

        def alphabeta(alpha, beta, depthleft):
            bestscore = -9999
            if (depthleft == 0):
                return quiesce(alpha, beta)
            for move in board.legal_moves:
                board.push(move)
                score = -alphabeta(-beta, -alpha, depthleft - 1)
                board.pop()
                if (score >= beta):
                    return score
                if (score > bestscore):
                    bestscore = score
                if (score > alpha):
                    alpha = score
            return bestscore
        
        def quiesce(alpha, beta):
            stand_pat = evaluate_board()
            if (stand_pat >= beta):
                return beta
            if (alpha < stand_pat):
                alpha = stand_pat
            for move in board.legal_moves:
                if board.is_capture(move):
                    board.push(move)
                    score = -quiesce(-beta, -alpha)
                    board.pop()
                    if (score >= beta):
                        return beta
                    if (score > alpha):
                        alpha = score
            return alpha

        # bestMove = chess.Move.null()
        # bestValue = -99999
        # alpha = -100000
        # beta = 100000
        # depth = difficulty
        # for move in board.legal_moves:
        #     board.push(move)
        #     boardValue = -alphabeta(-beta, -alpha, depth - 1)
        #     if boardValue > bestValue:
        #         bestValue = boardValue
        #         bestMove = move
        #     if (boardValue > alpha):
        #         alpha = boardValue
        #     board.pop()
        # board.push(bestMove)
        # print("move = " + bestMove.uci())
        # print("--- new board ---")
        # print(board)
        # print(board.fen())

        # using stockfish engine for next move
        # Set the difficulty level (optional)
        # engine.configure({"Skill Level": 1})  # Scale from 0-20, 20 being the strongest

        # Get the best move from the current position
        engine = chess.engine.SimpleEngine.popen_uci(STOCKFISH_PATH)
        result = engine.play(board, chess.engine.Limit(time=1.0))  # 2 seconds for the move
        print("Best move:", result.move)

        # Make the move on the board (optional)
        board.push(result.move)
        print(board)

        return "Success"

@app.route("/get-board", methods=["GET"])
def get_board():
    print("GET REQUEST RECEIVED")
    with board_lock:
        global board

    
        full_fen = board.fen()

        # Extract only the piece placement part
        piece_placement = full_fen.split(' ')[0]
        # Reverse the piece placement part
        # piece_placement = "/".join(reversed(piece_placement.split("/")))
        # return "rnbqkbnr/pppppppp/8/8/2P5/8/PP1PPPPP/RNBQKBNR"
        print("output string = " + piece_placement)
        return piece_placement

if __name__ == '__main__':
    app.run(debug=True)