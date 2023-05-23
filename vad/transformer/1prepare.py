import random
from pathlib import Path
from uphill import (
    Document,
    DocumentArray, 
    AlignmentDocument,

    Supervision,
    SupervisionArray,
)


wav_dir = "download/aishell/data_aishell/wav"
wav_dir = Path(wav_dir)

dev_dir = wav_dir / "dev"
test_dir = wav_dir / "test"

for name in ["dev", "test"]:
    curr_dir = wav_dir / name
    wav_docs = DocumentArray.from_dir(curr_dir, pattern="*.wav", num_jobs=6)
    sup_array = SupervisionArray()

    for wav_doc in wav_docs:
        idx = wav_doc.id
        if wav_doc.duration < 2.5e-3:
            continue
        
        sample_count = random.sample(list(range(3,9)), 1)[0]

        segments = []
        prev_end = 0.0
        for count_i in range(sample_count-1):
            start = round(prev_end, ndigits=7)
            duration = round(
                max(0.025, wav_doc.duration/sample_count), 
                ndigits=7
            )
            segments.append((count_i%2, start, duration))
            prev_end = start + duration
        ## last one
        start = round(prev_end, ndigits=7)
        duration = round(wav_doc.duration-start, ndigits=7)
        segments.append(((sample_count-1)%2, start, duration))

        alignment = AlignmentDocument.from_segments(segments)
        supervision = Supervision(
            source=wav_doc,
            target=alignment,
            id=idx
        )
        sup_array.append(supervision)
    wav_docs.to_file(f"data/wav_documents_{name}.jsonl")
    sup_array.to_file(f"data/supervisions_{name}.jsonl")




