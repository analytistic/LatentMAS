
mkdir -p logs

MODEL="/home/models/Qwen3-8B"
TASK="medqa"
MAX_SAMPLES=-1        
LATENT_STEPS=10
SEED=42
PROMPT='sequential'
DEVICE="cuda:6"
BATCHSIZE=10
CHUNK=1
think=True
latent_space_realign=True
use_vllm=False
enable_prefix_caching=True
use_second_HF_model=True
DEVICE2="cuda:7"



python -u run.py \
  --method latent_mas \
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
  2>&1 | tee "logs/$(date +%Y%m%d_%H%M%S)_latentmas_${TASK}_$(echo $MODEL | tr '/' '_')_chunk_$CHUNK.log"