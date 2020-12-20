#!/bin/bash

deploy_file=deploy_testing_suite.sh
deployment_file_list=deployment_files.txt

# add initial components
echo '#!/bin/bash' > $deploy_file
for component in testing_suite_component_*; do
    echo
    echo '####' $component '####'
    cat $component
done >> $deploy_file

echo >> $deploy_file
echo '####' testing scripts and licenses '####' >> $deploy_file
while IFS="" read -r line
do
    if [ -n "$line" ]; then
        echo
        echo "base64 -di $line > $line <<'EOF'"
        base64 $line
        echo EOF
    fi
done < $deployment_file_list >> $deploy_file

echo >> $deploy_file
echo echo >> $deploy_file
echo echo Please enable I2C by running raspi-config and then reboot. >> $deploy_file