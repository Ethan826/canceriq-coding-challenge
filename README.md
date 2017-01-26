CancerIQ Coding Challenge
=========================

A command-line utility for converting an input file specifying nodes and
edges, along with a list of operations, into an output file reflecting
the results of those operations.

Usage
-----

```bash
$> ruby main.rb /home/foouser/datafiles/input01.txt
```

The output will appear as `output.txt` in the current directory.

Specs
-----

Run `bundle install`, then run `rspec` from the root directory.

Input
-----

The input file must adhere to the format:

```text
3
1 2
1 3
2
add 2 20
max 1 2
```

As it stands, there is no cleansing performed. A further iteration could
involve removing extra whitespace or newlines. Further cleansing appears
unwise in that the final output depends significantly on the input. The
utility does not seek to handle incorrect data, either. For example, the
program will crash with an index out of bounds error if an edge is
specified connecting a node that does not exist.

The following regular expression can be used to verify files:

```regex
                Edges                    Operations
                --------------v          -----------------------------------------v
    \A(\d+\r?\n)(\d+ \d+\r?\n)+(\d+\r?\n)((add|max) \d+ -?\d+((\r?\n)|(\r?\n)?\Z))+
    -----------^               ---------^
    Number of nodes            Number of operations
```

Algorithm
---------

### Data structures

The tree is stored in an array of structs. The index of each struct in
the array represents its node number. Each struct contains the node’s
parent as a scalar, its children as a vector, and its 0-indexed depth.

The values are stored in an array of integers. The index of each integer
in the array represents its node number.

We build the data structure by creating an adjacency list (an
Array<Array<int>&gt;) from the list of edges in the input file, where
the index is the node number and the values in the array are the
connnected node numbers. This should be an `O(n)` operation for `n`
edges. We then compile the representation of the tree by moving from
each parent to its children, recording the parent, children and depth,
for what I believe is another `O(n)` operation.

### Operations

Adding to a node and all its children requires two steps. First, the
node is looked up. Each of its descendents are looked up, and so on,
until the leaves are reached. The array lookup and adding the node to
the running list are each `O(1)`, so traversing down a tree is, I
believe, `O(n)` for `n` children nodes.

Next, the value array is mutated in place for each of the `n` children,
another linear-time operation. Therefore, I think the entire operation
is `O(constant * n)`, or `O(n)`.

Finding the max along a path begins by looking up the starting and
ending nodes, each a constant-time operation. Because nodes store their
depths, we traverse up from the deepest node, accumulating node numbers
on the way. Once the depths of the two nodes are the same, we see if
they are equal. If not, we go up a level from both nodes, and again see
if they are the same, repeating until converge on the common parent.
This is an `O(n)` operation. We avoid de-duplicating the collection,
which would require sorting and shifting there is a penalty for space,
but it saves runtime.

Now we lookup each node number in the values array, using a reduce
rather than max so we can look up the values and find the max in a
single pass (rather than mapping and then taking max). This is another
`O(n)` operation, so again it appears the total is `O(constant * n)`, or
`O(n)`.

We could memoize routes if we wanted to trade space for speed.

Given `n` nodes with `m` operations, I believe the runtime complexity
overall is `O(n * m)`.
