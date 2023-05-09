SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

src_dir=$SCRIPT_DIR/download
tgt_dir=./data

. $SCRIPT_DIR/../../tools/parse_options.sh

echo "start download aishell"
uh download --dataset aishell --target_dir $src_dir
echo "finish"

echo "start prepare aishell"
uh prepare --dataset aishell --corpus_dir $src_dir/aishell --target_dir $tgt_dir --num_jobs 8 --compress
echo "finish"


