git add . &&
git commit -m $1 &&
git push origin master &&
ssh root@137.74.194.139 <<EOF
cd aulaHaskell &&
git pull origin master &&
stack build &&
lsof -i:80 -Fp | sed  's/^p//' | head -n -1 | xargs kill -9;
nohup stack exec aulaHaskell > /dev/null
echo "deploy finished!"
EOF