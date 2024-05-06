#!/bin/bash

PS3='Which model do you want to train? '
options=("ODE + RNN + Attention" \
         "*ABLATION* RNN + Attention" \
         "*ABLATION* RNN" \
         "QUIT")
separator="===================================="
model=""
modelName=""

select opt in "${options[@]}"
do
    case $opt in
        "ODE + RNN + Attention")
            model="ode_birnn_attention"
            modelName=$opt
            break
            ;;
        "*ABLATION* RNN + Attention")
            model="birnn_attention"
            modelName=$opt
            break
            ;;
        "*ABLATION* RNN")
            model="birnn"
            modelName=$opt
            break
            ;;
        "QUIT")
            exit 0
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# Train specific model.
python3 ./related_code/helper_train_model.py "$model" "$modelName"
exit $?
