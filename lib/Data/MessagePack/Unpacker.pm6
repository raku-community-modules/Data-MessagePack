use v6;

module Data::MessagePack::Unpacker {

    our sub unpack( Blob $b ) {
        my $position = 0;
        _unpack( Buf.new( $b ), $position );
    }

    sub _unpack( Buf $b, Int $position is rw ) {
        given $b[$position++] {
            when 0xc0 { return Any }
            when 0xc2 { return False }
            when 0xc3 { return True }
            #bin
            when 0xc4 { return _unpack-bin($b, $position, _unpack-uint( $b, $position, 1 )) }
            when 0xc5 { return _unpack-bin($b, $position, _unpack-uint( $b, $position, 2 )) }
            when 0xc6 { return _unpack-bin($b, $position, _unpack-uint( $b, $position, 4 )) }
            # extension
            when 0xc7 { ... }
            when 0xc8 { ... }
            when 0xc9 { ... }
            #floats
            when 0xca { }
            when 0xcb { }
            #uint
            when 0xcc { _unpack-uint( $b, $position, 1 ) }
            when 0xcd { _unpack-uint( $b, $position, 2 ) }
            when 0xce { _unpack-uint( $b, $position, 4 ) }
            when 0xcf { _unpack-uint( $b, $position, 8 ) }
            #int
            when 0xd0 { _unpack-uint( $b, $position, 1 ) -^ 0xff - 1 }
            when 0xd1 { _unpack-uint( $b, $position, 2 ) -^ 0xffff - 1 }
            when 0xd2 { _unpack-uint( $b, $position, 4 ) -^ 0xffffffff - 1 }
            when 0xd3 { _unpack-uint( $b, $position, 8 ) -^ 0xffffffffffffffff - 1 }
            #fixext
            when 0xd4 { ... }
            when 0xd5 { ... }
            when 0xd6 { ... }
            when 0xd7 { ... }
            when 0xd8 { ... }
            #strings
            when 0xd9 { }
            when 0xda { }
            when 0xdb { }
            #array
            when 0xdc { }
            when 0xdd { }
            #map
            when 0xde { }
            when 0xdf { }
            #positive fixint 0xxxxxxx	0x00 - 0x7f
            #fixmap          1000xxxx	0x80 - 0x8f
            #fixarray        1001xxxx	0x90 - 0x9f
            #fixstr          101xxxxx	0xa0 - 0xbf
            #negative fixint 111xxxxx	0xe0 - 0xff

        }
    }

}

sub _unpack-uint( Buf $b, Int $position is rw, Int $byte-count ) {
    my Int $res = 0;
    for ^$byte-count {
        $res +<= 8;
        $res += $b[$position++];
    }
    return $res;
}

sub _unpack-bin( Buf $b, Int $position is rw, Int $length ) {
    my $blob = Blob.new( $b[$position .. ($position + $length - 1)] );
    $position += $length;
    return $blob;
}

# vim: ft=perl6