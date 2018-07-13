# WIP jepsen.link

Implementing Jepsen testing for the Ableton Link protocol

## Usage

To run in Docker locally

```
# clone this project and note the path
git clone https://github.com/xavriley/jepsen-ableton-link.git

# clone the Jepsen project to another folder
git clone https://github.com/jepsen-io/jepsen.git
cd jepsen/docker
export JEPSEN_ROOT="/path/to/jepsen.link"
./up.sh --dev

# in another window
docker exec -it jepsen-control bash
lein run test
cat store/latest/*/link.log
```

These tests don't currently do alot - they install the ruby_ableton_link gem on
the nodes and start a session before outputting their status for 100 beats.

More rigorous testing and nicer output is under development.

## License

Copyright © 2018 Xavier Riley

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
