# runai-demo-files

one-liner for training
```bash
for i in {1..10}; do echo "Epoch $i"; for j in {1..20}; do printf "\r  Step $j/20 | loss: %.4f" "$(awk 'BEGIN{srand(); print rand()}')"; sleep 0.1; done; echo ""; echo "ckpt_$i" > "ckpt_$i.pt"; done
```
