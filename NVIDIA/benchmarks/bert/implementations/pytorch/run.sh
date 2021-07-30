PTY_DATA_DIR=/home/scratch.rewang_sw/DeepLearningExamples/PyTorch/LanguageModeling/BERT/data/hdf5_lower_case_1_seq_len_128_max_pred_20_masked_lm_prob_0.15_random_seed_12345_dupe_factor_5/wikicorpus_en
for bs in 8 16 32;
do
. config_DGXA100_1x1x${bs}x1.sh
CONT=${USER}/mlperf-v1.0-nvidia:language_model \
DATADIR=$PTY_DATA_DIR \
DATADIR_PHASE2=$PTY_DATA_DIR \
EVALDIR=$PWD/bert_data/eval_set_uncompressed \
CHECKPOINTDIR=$PWD/bert_data \
CHECKPOINTDIR_PHASE1=$PWD/bert_data \
./run_with_docker.sh
done
