# Aishell example

Following 3 steps to train model using aishell dataset

## prepare dataset
```
./1prepare.sh
```
This is a script without any parameters. This script would download the aishell dataset and prepare automatically for following use.

If you have the aishell dataset downloaded before, you can also put the tar files in folder `download/aishell_tar` and then run this script.


## train model
```
./2train.sh --model MODEL_NAME
```
Here, `model` is the file name of yaml configuration in `conf` directory. The name of configuration contains 3 characters: 

1. `C` means Conformer, `T` is transformer, 
2. `F` means offline mode, `S` means dynamic training mode, 
3. `U` means uni-direction, `B` means bi-direction.

For example, `CFB.yaml` is the offline bi-directional conformer model.

Default model directory is `exp/[model_name]`, and checkpoints, training logs, tensorboard records and decoding results in the next step are all saved in the directory.


## decode result
```
./3decode.sh --model_dir MODEL_DIR --mode DECODING_MODE [--chunk_size CHUNK_SIZE] [--num_left_chunks NUM_LEFT_CHUNKS] [--reverse_weight REVERSE_WEIGHT]
```
Here, 

- `model_dir` is the saved model directory in the last step, such as `exp/CFB`.
- `decoding_mode` is decoing mode, which should be one of `ctc_greedy`, `ctc_prefix_beam`, `attention` and `attention_rescoring`.
- `chunk_size` (optional) is decoding chunk size only when using stream model, not necessary for offline model.
- `num_left_chunks` (optional) is number of left context chunks only when using stream model, not necessary for offline model.
- `reverse_weight` (optional) is only used for the right-to-left decoder of the bi-directional decoder in `attention_rescoring` mode.

[RESULTS.md](./RESULTS.md) is the results trained by the scripts for reference.
