# runai-demo-files

one-liner for training
```bash
for i in {1..10}; do echo "Epoch $i"; for j in {1..100}; do printf "\r  Step $j/20 | loss: %.4f" "$(awk 'BEGIN{srand(); print rand()}')"; sleep 0.1; done; echo ""; echo "ckpt_$i" > "ckpt_$i.pt"; done
```

alternatively
```bash
EPOCHS=100; STEPS=30; CKPT_DIR=./lightning_logs/version_0/checkpoints; mkdir -p "$CKPT_DIR"; ts(){ date +"%Y-%m-%d %H:%M:%S"; }; echo "$(ts) | INFO | GPU available: True, used: True"; echo "$(ts) | INFO | TPU available: False"; echo "$(ts) | INFO | Initializing distributed: GLOBAL_RANK: 0, MEMBER: 1/1"; for ((e=0;e<EPOCHS;e++)); do echo "$(ts) | INFO | Epoch $e"; for ((s=1;s<=STEPS;s++)); do loss=$(awk -v min=0.05 -v max=0.8 'BEGIN{srand(); print min+rand()*(max-min)}'); acc=$(awk -v min=0.5 -v max=0.99 'BEGIN{srand(); print min+rand()*(max-min)}'); p=$((s*100/STEPS)); bar=$(printf "%-${p}s" "#" | tr ' ' '#'); sp=$(printf "%-$((100-p))s"); printf "\rEpoch $e: %3d%%|%s%s| %d/%d [loss=%.4f, acc=%.4f]" "$p" "$bar" "$sp" "$s" "$STEPS" "$loss" "$acc"; sleep 0.05; done; echo ""; ckpt="$CKPT_DIR/epoch=${e}-step=$((e*STEPS)).ckpt"; echo "mock weights epoch $e" > "$ckpt"; echo "$(ts) | INFO | Saving checkpoint to $ckpt"; done; echo "$(ts) | INFO | Training finished."
```
