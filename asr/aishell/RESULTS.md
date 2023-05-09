> all results without brackets are trained by 8 GPUs.

## Offline 

### uni-directional decoder
traning with full attention mask with decoding ctc weight 0.5

| model / decoding mode | config               | attention rescore | attention   | ctc greedy  | ctc prefix  |  download |
|-----------------------|----------------------|-------------------|-------------|-------------|-------------|-----------|
| transformer           | [TFU](conf/TFU.yaml) | 5.13              | 5.47        | 5.59        | 5.59        | [TFU](https://huggingface.co/yinanxu/aishell/resolve/main/TF00.pt) |
| conformer             | [CFU](conf/CFU.yaml) | 4.50              | 4.84        | 4.77        | 4.77        | [CFU](https://huggingface.co/yinanxu/aishell/resolve/main/CF00.pt) |

### bi-directional decoder
traning with dynamic-chunk attention mask, 

| model / decoding mode | config               | attention rescore | attention | ctc greedy | ctc prefix |
|-----------------------|----------------------|-------------------|-----------|------------|------------|
| transformer           | [TFB](conf/TFB.yaml) | 5.14              | 5.35      | 5.68       | 5.68       |
| conformer             | [CFB](conf/CFB.yaml) | 4.56              | 4.67      | 4.79       | 4.79       |


# Stream

## Uni-Directional Decoder
traning with dynamic-chunk attention mask, 

### Transformer
config is [TSU](conf/TSU.yaml), num of decoding-left chunks is 10

| decoding mode/chunk size | full  | 16    | 8     | 4     |
|--------------------------|-------|-------|-------|-------|
| attention rescore        | 5.79  | 6.44  | 6.89  | 7.83  |
| attention                | 6.11  | 6.40  | 6.47  | 6.86  |
| ctc greedy               | 6.55  | 7.68  | 8.49  | 10.02 |
| ctc prefix beam          | 6.54  | 7.68  | 8.49  | 10.02 |

### conformer
config is [CSU](conf/CSU.yaml), num of decoding-left chunks is 10

| decoding mode/chunk size | full  | 16    | 8     | 4     |
|--------------------------|-------|-------|-------|-------|
| attention rescore        | 4.81  | 4.96  | 5.03  | 5.16  |
| attention                | 5.17  | 5.32  | 5.38  | 5.46  |
| ctc greedy               | 5.16  | 5.42  | 5.49  | 5.63  |
| ctc prefix beam          | 5.16  | 5.42  | 5.49  | 5.63  |


## Bi-Directional Decoder
traning with dynamic-chunk attention mask, 

### Transformer
config is [TSB](conf/TSB.yaml), num of decoding-left chunks is 10, reverse weight is 0.5

| decoding mode/chunk size | full  | 16    | 8     | 4     |
|--------------------------|-------|-------|-------|-------|
| attention rescore        | 5.54  | 6.11  | 6.57  | 7.53  |
| attention                | 5.74  | 5.99  | 6.16  | 6.48  |
| ctc greedy               | 6.33  | 7.34  | 8.26  | 9.93  |
| ctc prefix beam          | 6.33  | 7.33  | 8.26  | 9.91  |

### conformer
config is [CSB](conf/CSB.yaml), num of decoding-left chunks is 10, reverse weight is 0.5

| decoding mode/chunk size | full  | 16    | 8     | 4     |
|--------------------------|-------|-------|-------|-------|
| attention rescore        | 4.77  | 4.91  | 4.98  | 5.10  |
| attention                | 4.93  | 5.07  | 5.13  | 5.25  |
| ctc greedy               | 5.12  | 5.28  | 5.35  | 5.51  |
| ctc prefix beam          | 5.11  | 5.28  | 5.35  | 5.50  |

