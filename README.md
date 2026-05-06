# UART Communication Protocol (TX/RX) – Verilog

## Overview

Implemented UART Transmitter and Receiver modules with configurable baud rate (9600 bps).

---

## Features

* Baud Rate Generator
* FSM-based TX (Start, Data, Stop)
* FSM-based RX
* Loopback verification
* 8-bit data frame

---

## Design

* TX: Serializes parallel data
* RX: Deserializes incoming data
* Tick generator controls timing

---

## Simulation

Verified using testbench (loopback)

---

## Files

* uart_tx.v
* uart_rx.v
* baud_gen.v
* tb_uart.v

---

## Author

Yashvanthini Selvam
