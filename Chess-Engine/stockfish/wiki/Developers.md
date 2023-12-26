## Windows Development Setup

1. https://www.msys2.org/
2. Download the installer

In the MSYS2 Installer change the installation folder to:  
`C:\tools\msys64`

In the `URTC64` Shell run:  
`pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain`

### clang-format
From https://github.com/llvm/llvm-project/releases/tag/llvmorg-17.0.3 download `LLVM-17.0.3-win64.exe`

Run the executable and in the installer choose:  
`Add LLVM to the system PATH for current user`

Finally rename `mingw32-make` to `make` in `C:\tools\msys64\ucrt64\bin`


## Participating in the project

Stockfish's improvement over the last decade has been a great community effort.
Nowadays most development talk takes place on [Discord](https://discord.gg/GWDRS3kU6R).

There are many ways to contribute to Stockfish:

- [Stockfish](#stockfish) (C++)
- [Fishtest](#fishtest) (Python)
- [nnue-pytorch](#nnue-pytorch) (C++ and Python)
- [Donating hardware](#donating-hardware)

### Stockfish

If you want to contribute to Stockfish directly, you can do so in a couple of ways.
Follow the steps described in our [Fishtest wiki](https://github.com/official-stockfish/fishtest/wiki/Creating-my-first-test),
and enjoy [creating your first test](https://github.com/official-stockfish/fishtest/wiki/Creating-my-first-test).

#### Non functional changes

These are changes that don't change the search behaviour and can be directly
submitted as pull requests, for example:

- Code cleanups
- Comments
- New commands

#### Functional changes

These change the search behaviour and lead to a different search tree.  
Every functional patch (commit) has to be verified by
[Fishtest](https://tests.stockfishchess.org/tests), our testing framework.

### Fishtest

New commits to stockfish can mostly be categorised in 2 categories:

### NNUE Pytorch

NNUE Pytorch is the trainer for Stockfish's neural network. Usually changes here are
tested by training a new network and testing it against the current network via Fishtest.

### Donating hardware

Improving Stockfish requires a massive amount of testing. You can donate your hardware resources by installing the [Fishtest Worker](https://github.com/official-stockfish/fishtest/wiki/Running-the-worker) and view the current tests on [Fishtest](https://tests.stockfishchess.org/tests).

---

## Using Stockfish in your own project

### Resources

- [Advanced topics](Advanced-topics)
- [Commands](UCI-&-Commands)
- [Useful data](Useful-data)

### Terms of use

Stockfish is free and distributed under the [**GNU General Public License version 3**](https://github.com/official-stockfish/Stockfish/blob/master/Copying.txt) (GPL v3). Essentially, this means you are **free to do almost exactly what you want** with the program, including **distributing it** among your friends, **making it available for download** from your website, **selling it** (either by itself or as part of some bigger software package), or **using it as the starting point** for a software project of your own. This also means that you can distribute Stockfish [alongside your proprietary system](https://www.gnu.org/licenses/gpl-faq.html#GPLInProprietarySystem), but to do this validly, you must make sure that Stockfish and your program communicate at arm's length, that they are not combined in a way that would make them effectively a single program.

The only real limitation is that whenever you distribute Stockfish in some way, **you MUST always include the license and the full source code** (or a pointer to where the source code can be found) to generate the exact binary you are distributing. If you make any changes to the source code, these changes must also be made available under GPL v3.
