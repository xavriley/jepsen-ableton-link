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
lein run test --time-limit 180 --no-teardown --topology line --network-delay 0.5
```

Once that has completed, run

```
grep -Hn '^' store/latest/{jepsen.log,history.edn,n*/link.log,n*/iptables.log} | ruby tempo-grapher.rb && open plot.pdf
```

To generate the graphs.

See ![the plot.pdf files in figures_for_publication](figures_for_publication/connected_no_delay/plot.pdf) for examples of the output.

## License

Copyright © 2018 Xavier Riley

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
