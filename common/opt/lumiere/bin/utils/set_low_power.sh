#!/bin/bash

i2cset -y 1 0x1b 0x12 0x00 0x00 0x01 0x5e i
i2cset -y 1 0x1b 0x13 0x00 0x00 0x01 0x5e i
i2cset -y 1 0x1b 0x14 0x00 0x00 0x01 0x5e i

i2cset -y 1 0x1b 0x3a 0x00 0x00 0x00 0x01 i
i2cset -y 1 0x1b 0x39 0x00 0x00 0x00 0x00 i
i2cset -y 1 0x1b 0x38 0x00 0x00 0x00 0xd3 i

sleep 1

