
mkdir -p logs

METHOD="latent_mas"
MODEL="/home/models/Qwen3-8B"
TASK="medqa"
MAX_SAMPLES=-1        
LATENT_STEPS=10
SEED=42
PROMPT='sequential'
DEVICE="cuda:3"
BATCHSIZE=5
CHUNK=3
think=True
latent_space_realign=True
use_vllm=False
enable_prefix_caching=True
use_second_HF_model=True
DEVICE2="cuda:7"

mkdir -p logs/${TASK}/${METHOD}

python -u run.py \
  --method "$METHOD" \
  --model_name "$MODEL" \
  --max_samples "$MAX_SAMPLES" \
  --task "$TASK" \
  --chunk "$CHUNK" \
  --prompt "$PROMPT" \
  --device "$DEVICE" \
  --latent_steps "$LATENT_STEPS" \
  --seed "$SEED" \
  --think \
  --latent_space_realign \
  --enable_prefix_caching \
  --use_second_HF_model \
  --device2 "$DEVICE2" \
  --tensor_parallel_size 1 \
  --gpu_memory_utilization 0.85 \
  --generate_bs "$BATCHSIZE"\
  2>&1 | tee "logs/${TASK}/${METHOD}/$(echo $MODEL | tr '/' '_')_chunk_${CHUNK}.log"