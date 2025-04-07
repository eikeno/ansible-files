mkdir -p submodules
git submodule add https://github.com/mnussbaum/ansible-yay submodules/ansible-yay
chmod +x submodules/ansible-yay/yay
pushd library
ln -s ../submodules/ansible-yay/yay .
popd

