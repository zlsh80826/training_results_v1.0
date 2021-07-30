# Location of the input files 

This [MLCommons members Google Drive location](https://drive.google.com/drive/u/0/folders/1oQF4diVHNPCclykwdvQJw8n_VIWwV0PT) contains the following.
* TensorFlow checkpoint (tf1_ckpt) containing the pre-trained weights (which is actually 3 files).
* Vocab file (vocab.txt) to map WordPiece to word id.
* Config file (bert_config.json) which specifies the hyperparameters of the model.

Download these files to a new directory called `bert_data/`

# Checkpoint conversion

Build the Docker container
```shell
bash build.sh
```

Start the container interactively, mounting `bert_data/` as `/cks`, then run
```
bash launch.sh
python convert_tf_checkpoint.py --tf_checkpoint /cks/model.ckpt-28252.index --bert_config_path /cks/bert_config.json --output_checkpoint /cks/model.ckpt-28252.pt
```
Then exit the container

#  Evaluation data

Use the following steps to create the eval set in a directory called `eval_set_uncompressed/`:

For benchmark, evaluation data is not necessary. Create an empty directory is ok
```
mkdir bert_data/eval_set_uncompressed
```

# Benchmark

Modify [run.sh](run.sh#1) to the path of DLExamples dataset
```
bash run.sh
```
