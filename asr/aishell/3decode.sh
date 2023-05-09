#!/bin/bash

##### model related args
model_dir=
epoch=80
avg_num=5
by_metric=

##### decoding related args
mode=
chunk_size=
num_left_chunks=
reverse_weight=


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
. $SCRIPT_DIR/../../tools/parse_options.sh

train_config=${model_dir}/hparams.yaml
epoch_num=`printf "%04d\n" $epoch`
avg_pt=${model_dir}/avg_ckpt_ep${epoch_num}_avg${avg_num}.pth
decode_dir=${model_dir}/result_${mode}_avg${avg_num}${chunk_size:+_$chunk_size}${num_left_chunks:+_$num_left_chunks}
mkdir -p ${decode_dir}
decode_result=${decode_dir}/decoding_result.jsonl
wer_result=${decode_dir}/wer.txt

if [ ! -f ${avg_pt} ]; then
    echo "averaged model not exists, compute averaged model"
    mt average --model_dir ${model_dir} --epoch $epoch --avg $avg_num ${by_metric:+--by_metric} || exit 1
fi

echo "start decoding"
mt asr decode --config ${train_config} --mode ${mode} --gpu 0 --dict data/words.txt \
    --checkpoint ${avg_pt} --num_workers 8 --ctc_weight 0.5 \
    --result_file ${decode_result} \
    ${chunk_size:+--chunk_size $chunk_size} \
    ${num_left_chunks:+--num_left_chunks $num_left_chunks} \
    ${reverse_weight:+--reverse_weight $reverse_weight} || exit 1

echo "computing wer"
mt asr wer --ref_file data/text_documents_test.jsonl.gz --hyp_file ${decode_result} --result_file ${wer_result} || exit 1

echo "finish"

