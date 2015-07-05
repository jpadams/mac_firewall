# mac_firewall
Let's you define the state that the firewall should be in.

This module provides a class `mac_firewall` that has a single attribute `mode`.
`mode` has four legal values: `off`, `on`, `stealthmode`, `blockall`.

It also provides a new fact, `mac_firewall_state` which can have the same values as mode above.

Tested on Mac OS X 10.9, 10.10.
