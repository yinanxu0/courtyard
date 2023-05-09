#!/bin/bash

model=CFU

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
. $SCRIPT_DIR/../../tools/parse_options.sh

num_nodes=1
num_gpus=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
# Use "nccl" if it works, otherwise use "gloo"
dist_backend="nccl"

train_config="conf/${model}.yaml"

if [[ ! $num_gpus > 0 ]]; then
    echo "using cpu mode, setting num_gpus to 1"
    num_gpus=1
fi

export OMP_NUM_THREADS=3
torchrun --nnodes=${num_nodes} --nproc_per_node=${num_gpus} --no_python \
    mountaintop train --config $train_config --model_dir exp/${model} \
    --world_size $num_gpus --dist_backend $dist_backend \
    --num_workers 4 --pin_memory


