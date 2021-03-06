
STEPSIZE=50000

mkdir output/samplesize

for SAMPLESIZE in 2 4 8 16 32 64 128 256
do
    for ITERATION in {2..10}
    do
        python trainer/task.py --train-files ./data/filtered/output* --job-dir ./output/samplesize/$SAMPLESIZE --sample_size $SAMPLESIZE --train-steps $(($ITERATION * $STEPSIZE))
        python generate.py --samples 1000 --out_path ./output/samplesize/notalk\_$SAMPLESIZE\_$(($ITERATION * $STEPSIZE)) --dat_seed ./data/filtered/output.dat output/samplesize/$SAMPLESIZE/model.ckpt-$(($ITERATION * $STEPSIZE))
        mkdir -p output/samplesize/backup/$SAMPLESIZE
        cp output/samplesize/$SAMPLESIZE/model.ckpt-$(($ITERATION * $STEPSIZE))* output/samplesize/backup/$SAMPLESIZE/
    done
done

