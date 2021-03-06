# Day 23: Category Six

## Approach and Reflections

Day 23 was a blast! We had to spawn 50 copies of our intcode computers and
have them send messages to each other over a network.

I went with two approaches; Python for a cooperative multitasking
/ timeslicing approach, and Elixir for a truely concurrent approach.

Up until this point, my VMs always paused if they needed input that was not
available. I assumed most others built theirs this way too. The specs for
this problem indiciate that the VMs must run non-blocking and receive a -1 if
they ask for input when there is nothing in their network queue.

A fairly simple approach of holding a network queue for each machine, stepping
through each VM, inputting either -1 or a packet from its network queue,
letting it run until it asked for input again, then pausing and moving to the
next VM was enough to work. This is what the python solution does.
A drawback here is that it requires cooperation from the VMs; if one of them
goes rogue and loops infinitely, the entire system is stuck and stops working.
This was not an issue in today's problem, though.

My elixir solution uses a more sophisticated approach: All 50 VMs run in their
own process and get input/output from a single coordinator process, which
stores a network queue for each machine. This is a more robust solution, as
1 VM infinitely looping would no longer take down the entire system. It also
uses multiple cores to their full effect. The downside is, more VMs are busy
looping, but that is a downside of the intcode program itself.

## Solutions

- [Python](./python_day23/aoc/day23.py) [(test)](./python_day23/day23_test.py)
- [Elixir](./elixir_day23/lib/coordinator.ex)
  [(test)](./elixir_day23/test/elixir_day13_test.exs)

The elixir version uses actual concurrency, spawning 50 beam processes; one
process for each intcode machine (which runs non-blocking).

The python version uses cooperative multitasking; a single thread loops
through the computers, allowing each computer to run until it asks for input.
That computer is then paused and the next one is run.

## Problem Description

[2019 Day 23 on AdventOfCode.com](https://adventofcode.com/2019/day/23)

### Part 1

The droids have finished repairing as much of the ship as they can. Their
report indicates that this was a Category 6 disaster - not because it was that
bad, but because it destroyed the stockpile of Category 6 network cables as
well as most of the ship's network infrastructure.

You'll need to rebuild the network from scratch.

The computers on the network are standard Intcode computers that communicate
by sending packets to each other. There are 50 of them in total, each running
a copy of the same Network Interface Controller (NIC) software (your puzzle
input). The computers have network addresses 0 through 49; when each computer
boots up, it will request its network address via a single input instruction.
Be sure to give each computer a unique network address.

Once a computer has received its network address, it will begin doing work and
communicating over the network by sending and receiving packets. All packets
contain two values named X and Y. Packets sent to a computer are queued by the
recipient and read in the order they are received.

To send a packet to another computer, the NIC will use three output
instructions that provide the destination address of the packet followed by
its X and Y values. For example, three output instructions that provide the
values 10, 20, 30 would send a packet with X=20 and Y=30 to the computer with
address 10.

To receive a packet from another computer, the NIC will use an input
instruction. If the incoming packet queue is empty, provide -1. Otherwise,
provide the X value of the next packet; the computer will then use a second
input instruction to receive the Y value for the same packet. Once both values
of the packet are read in this way, the packet is removed from the queue.

Note that these input and output instructions never block. Specifically,
output instructions do not wait for the sent packet to be received - the
computer might send multiple packets before receiving any. Similarly, input
instructions do not wait for a packet to arrive - if no packet is waiting,
input instructions should receive -1.

Boot up all 50 computers and attach them to your network. What is the Y value
of the first packet sent to address 255?

### Part 2

Packets sent to address 255 are handled by a device called a NAT (Not Always
Transmitting). The NAT is responsible for managing power consumption of the
network by blocking certain packets and watching for idle periods in the
computers.

If a packet would be sent to address 255, the NAT receives it instead. The NAT
remembers only the last packet it receives; that is, the data in each packet
it receives overwrites the NAT's packet memory with the new packet's X and
Y values.

The NAT also monitors all computers on the network. If all computers have
empty incoming packet queues and are continuously trying to receive packets
without sending packets, the network is considered idle.

Once the network is idle, the NAT sends only the last packet it received to
address 0; this will cause the computers on the network to resume activity. In
this way, the NAT can throttle power consumption of the network when the ship
needs power in other areas.

Monitor packets released to the computer at address 0 by the NAT. What is the
first Y value delivered by the NAT to the computer at address 0 twice in
a row?
