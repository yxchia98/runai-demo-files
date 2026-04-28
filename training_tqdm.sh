#!/bin/bash

EPOCHS=100
STEPS=50
CKPT_DIR="./checkpoints"

mkdir -p "$CKPT_DIR"

for ((e=1; e<=EPOCHS; e++)); do
  echo "Epoch $e/$EPOCHS"

  for ((s=1; s<=STEPS; s++)); do
    percent=$((s * 100 / STEPS))
    bar=$(printf "%-${percent}s" "#" | tr ' ' '#')
    spaces=$(printf "%-$((100-percent))s")

    loss=$(awk -v min=0.05 -v max=0.8 'BEGIN{srand(); print min+rand()*(max-min)}')

    printf "\r[%s%s] %3d%% | loss: %.4f" "$bar" "$spaces" "$percent" "$loss"
    sleep 0.05
  done

  echo ""
  ckpt="$CKPT_DIR/model_epoch_${e}.pt"
  echo "weights: fake_epoch_$e" > "$ckpt"
  echo "Checkpoint saved → $ckpt"
done
