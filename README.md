# Lean

Container image for Lean used by CodeRunner.

## Usage

```bash
W=/workspace/
# Create container
C=$(docker container create --rm -w $W ghcr.io/codewars/lean:latest lean test/SolutionTest.lean)

# Copy files from the current directory
# src/Solution.lean
# src/Preloaded.lean
# test/SolutionTest.lean
docker container cp src $C:$W
docker container cp test $C:$W

# Run tests
docker container start --attach $C
```

## Building

```bash
$ docker build -t ghcr.io/codewars/lean:latest .
```
