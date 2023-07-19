python train.py --save_path ckpt_segan+ \
                --batch_size 200 \
                --epoch 100 \
                --clean_trainset data/clean_trainset_wav_16k \
                --noisy_trainset data/noisy_trainset_wav_16k \
                --cache_dir data/cache