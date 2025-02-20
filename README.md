[![Actions Status](https://github.com/raku-community-modules/Data-MessagePack/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Data-MessagePack/actions) [![Actions Status](https://github.com/raku-community-modules/Data-MessagePack/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Data-MessagePack/actions) [![Actions Status](https://github.com/raku-community-modules/Data-MessagePack/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Data-MessagePack/actions)

NAME
====

Data::MessagePack - Raku implementation of MessagePack

SYNOPSIS
========

```raku
use Data::MessagePack;

my $data-structure = {
    key => 'value',
    k2 => [ 1, 2, 3 ]
};

my $packed = Data::MessagePack::pack( $data-structure );

my $unpacked = Data::MessagePack::unpack( $packed );

Or for streaming:

use Data::MessagePack::StreamingUnpacker;

my $supplier = Some Supplier; #Could be from IO::Socket::Async for instance

my $unpacker = Data::MessagePack::StreamingUnpacker.new(
    source => $supplier.Supply
);

$unpacker.tap( -> $value {
    say "Got new value";
    say $value.raku;
}, done => { say "Source supply is done"; } );
```

DESCRIPTION
===========

The present module proposes an implementation of the MessagePack specification as described on [http://msgpack.org/](http://msgpack.org/). The implementation is now in Pure Raku which could come as a performance penalty opposed to some other packer implemented in C.

FUNCTIONS
=========

function pack
-------------

That function takes a data structure as parameter, and returns a `Blob` with the packed version of the data structure.

function unpack
---------------

That function takes a `MessagePack` packed message as parameter, and returns the deserialized data structure.

Author
======

Pierre Vigier

Contributors
============

Timo Paulssen

Source can be located at: https://github.com/raku-community-modules/MessagePack . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2016 - 2018 Pierre Vigier

Copyright 2023, 2025 The Raku Community

