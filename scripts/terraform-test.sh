#!/usr/bin/env sh

planFile=${1}"/scripts/plan.tftest.hcl"
applyFile=${1}"/scripts/apply.tftest.hcl"

terraformVersionFile=${1}"/tfversion.md"
echo "" > $terraformVersionFile
version=""

f=${2}
success=true
echo $f
echo ""
echo "====> Terraform testing in" $f
./terraform -chdir=$f init -upgrade
echo ""
echo "----> Plan Testing"
cp $planFile $f/
./terraform -chdir=$f test test -verbose
if [[ $? -ne 0 ]]; then
    success=false
    echo -e "\033[31m[ERROR]\033[0m: running terraform test for plan failed."
else
    echo ""
    echo "----> Apply Testing"
    rm -rf $f/plan.tftest.hcl
    cp $applyFile $f/
    ./terraform -chdir=$f test test
    if [[ $? -ne 0 ]]; then
        success=false
        echo -e "\033[31m[ERROR]\033[0m: running terraform test for apply failed."
    fi
        rm -rf $f/apply.tftest.hcl
fi

version=$(./terraform -chdir=$f version)
row=`echo -e "$version" | sed -n '/^$/='`
if [ -n "$row" ]; then
    version=`echo -e "$version" | sed -n "1,${row}p"`
fi  

echo -e "### Versions\n" >> $terraformVersionFile 
echo -e "${version}" >> $terraformVersionFile 

if [[ $success == false ]]; then
    exit 1
fi

exit 0
