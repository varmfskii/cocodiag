#!/usr/bin/env python
import sys

def crc16table(poly, output):
    for i in range(256):
        k = i
        for j in range(8):
            if k&1:
                k^=poly
            k>>=1
        output.write(k.to_bytes(2,'big'))

if len(sys.argv) != 3:
    print(f'Usage {sys.argv[0]} <polynomial> <file>')
    exit

p = int(sys.argv[1], 16)

if p<0 or p>65536:
    print(f'polynomial {sys.argv[1]} out of range')
    exit

output = open(sys.argv[2], 'wb')
crc16table(p, output)
output.close()


