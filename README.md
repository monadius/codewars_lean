# Lean

Container image for Lean4 used by CodeRunner.

## Usage

```bash
W=/workspace
# Create container
C=$(docker container create --rm -w $W ghcr.io/codewars/lean4:latest lake build)

# Copy kata files to /workspace/Kata:
# Solution.lean
# Preloaded.lean
# Tests.lean
docker container cp ${1:-Kata}/. $C:$W/Kata/

# Run tests
docker container start --attach $C
```

These commands can be executed with `bin/run [path_to_example]`:
```bash
# Run the standard example located at Kata/
bin/run
# Run a calculus example
bin/run examples/calculus
```

## Building

```bash
$ docker build -t ghcr.io/codewars/lean:latest .
```