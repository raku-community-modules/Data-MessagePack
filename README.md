[![Actions Status](https://github.com/raku-community-modules/Raku-Data-MessagePack/workflows/test/badge.svg)](https://github.com/raku-community-modules/Raku-Data-MessagePack/actions)

NAME
====

Data::MessagePack - Perl 6 implementation of MessagePack

SYNOPSIS
========

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

DESCRIPTION
===========

The present module proposes an implemetation of the MessagePack specification as described on [http://msgpack.org/](http://msgpack.org/). The implementation is now in Pure Perl which could come as a performance penalty opposed to some other packer implemented in C.

WHY THAT MODULE
===============

There are already some part of MessagePack implemented in Perl6, with for instance MessagePack available here: [https://github.com/uasi/messagepack-pm6](https://github.com/uasi/messagepack-pm6), however that module only implements the unpacking part of the specification. Futhermore, that module uses the unpack functionality which is tagged as experimental as of today

FUNCTIONS
=========

function pack
-------------

That function takes a data structure as parameter, and returns a Blob with the packed version of the data structure.

function unpack
---------------

That function takes a MessagePack packed message as parameter, and returns the deserialized data structure.

Author
======

Pierre VIGIER

Contributors
============

Timo Paulssen

License
=======

Artistic License 2.0

