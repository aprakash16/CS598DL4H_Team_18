PS3='Which model do you want to train? '
options=("ODE + RNN + Attention" \
         "QUIT")
separator="===================================="
model=""
modelName=""

select opt in "${options[@]}"
do
    case $opt in
        "QUIT")
            exit 0
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# Train specific model.
python3 ./related_code/helper_train_model.py "$model" "$modelName"
exit $?
