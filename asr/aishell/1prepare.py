import os
import json
import uphill

root_dir = os.path.dirname(os.path.realpath(__file__))
src_dir = os.path.join(root_dir, "download")
tgt_dir = os.path.join(root_dir, "data")

corpus_dir = uphill.apply.aishell.download(src_dir)
manifests = uphill.apply.aishell.prepare(
    corpus_dir=corpus_dir, 
    target_dir=tgt_dir, 
    num_jobs=4, 
    compress=True,
)

#### get cmvn here
train_wav_path = os.path.join(tgt_dir, "wav_documents_train.jsonl.gz")

train_wav_array = uphill.DocumentArray.from_file(train_wav_path)

print("computing cmvn")
cmvn = train_wav_array.compute_cmvn()

print("writing cmvn")
cmvn_info = {
    'mean_stats': list(cmvn['mean_stats'].tolist()),
    'var_stats': list(cmvn['var_stats'].tolist()),
    'num_frames': cmvn['num_frames']
}
with open(os.path.join(tgt_dir, "train_cmvn"), 'w') as fout:
    fout.write(json.dumps(cmvn_info) + "\n")

print("finish!")

