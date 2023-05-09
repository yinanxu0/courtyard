#!/bin/bash

#### offline mode
for model in $(ls exp)
do    
    for mode in ctc_greedy ctc_prefix_beam attention attention_rescoring
    do
        if [[ ${model:2:3} = "B" && ${mode} = "attention_rescoring" ]]; then
            reverse_weight=0.5
        else
            reverse_weight=
        fi
        echo -e "\nDECODING exp/${model} ${mode}"
        ./3decode.sh --model_dir exp/${model} --mode ${mode} \
            ${reverse_weight:+--reverse_weight $reverse_weight}
    done
done


#### stream mode
for model in CSB CSU TSB TSU
do
    for mode in ctc_greedy ctc_prefix_beam attention attention_rescoring
    do
        for chunk_size in 16 8 4
        do 
            if [[ ${model:2:3} = "B" && ${mode} = "attention_rescoring" ]]; then
                reverse_weight=0.5
            else
                reverse_weight=
            fi
            echo "DECODING exp/${model} ${mode} ${chunk_size} 10"
            ./3decode.sh --model_dir exp/${model} --mode ${mode} \
                --chunk_size ${chunk_size} --num_left_chunks 10 \
                ${reverse_weight:+--reverse_weight $reverse_weight}
        done
    done
done



