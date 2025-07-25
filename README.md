# Task 3: 4-Stage Pipelined Processor

## Pipeline Stages:
1. **IF** – Instruction Fetch
2. **ID** – Instruction Decode
3. **EX** – Execute operation
4. **WB** – Write result back to register

## Supported Instructions:
- `ADD R1, R2, R3`
- `SUB R4, R5, R6`
- `LOAD R7, R8`

## Tools Used:
- ModelSim / Vivado
- GTKWave for waveform

## Notes:
- Opcode used from bits 31–28
- Register indices and data bits follow simple format
