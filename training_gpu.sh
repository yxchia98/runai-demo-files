#!/bin/bash

EPOCHS=100
STEPS=30
CKPT_DIR="./lightning_logs/version_0/checkpoints"

mkdir -p "$CKPT_DIR"

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

echo "$(timestamp) | INFO | GPU available: True, used: True"
echo "$(timestamp) | INFO | TPU available: False"
echo "$(timestamp) | INFO | HPU available: False"
echo "$(timestamp) | INFO | Initializing distributed: GLOBAL_RANK: 0, MEMBER: 1/1"

sleep 1

for ((e=0; e<EPOCHS; e++)); do
  echo "$(timestamp) | INFO | Epoch $e"

  for ((s=1; s<=STEPS; s++)); do
    loss=$(awk -v min=0.05 -v max=0.8 'BEGIN{srand(); print min+rand()*(max-min)}')
    acc=$(awk -v min=0.5 -v max=0.99 'BEGIN{srand(); print min+rand()*(max-min)}')

    percent=$((s * 100 / STEPS))
    printf "\rEpoch $e: %3d%%|████████████████████████████████| %d/%d [loss=%.4f, acc=%.4f]" \
      "$percent" "$s" "$STEPS" "$loss" "$acc"

    sleep 0.05
  done

  echo ""

  ckpt="$CKPT_DIR/epoch=${e}-step=$((e*STEPS)).ckpt"
  echo "mock weights epoch $e" > "$ckpt"

  echo "$(timestamp) | INFO | Saving checkpoint to $ckpt"
done

echo "$(timestamp) | INFO | Training finished."
