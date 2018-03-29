!/bin/bash

echo -e "> Fetching dependencies\n"
apt -y update && \
apt install -y tmux neovim vim curl build-essential software-properties-common && \
add-apt-repository ppa:git-core/pp && \
add-apt-repository ppa:gophers/archive && \
apt update -y
if [ $? -ne 0]; then
    echo -e "Failed to fetch dependencies. Aborting\n"
    exit 1
else
    echo -e "Successfully fetched dependencies\n"
fi

echo "> install and config git"
apt install -y git && \
git config --global user.name "arsidada" && \
git config --global user.email arsalan.rana@gmail.com
if [ $? -ne 0]; then
    echo -e "Failed to install git. Aborting\n"
    exit 1
else
    echo -e "Successfully installed and configured git\n"
fi

echo -e "> install docker and docker-compose\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
apt update -y && \
apt install -y docker-ce && \
usermod -a -G docker $USER && \
curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose
if [ $? -ne 0]; then
    echo -e "Failed to install docker and docker-compose. Aborting\n"
    exit 1
else
    echo -e "Successfully installed docker and docker-compose\n"
fi

echo -e "> install python\n"
apt install -y python3.6 && \
apt install -y python
if [ $? -ne 0]; then
    echo -e "Failed to install python. Aborting\n"
    exit 1
else
    echo -e "Successfully installed docker and docker-compose\n"
fi

echo -e "> install go\n"
apt install -y golang-1.10-go && \
mkdir -p ~/dev/go/src ~/dev/go/bin ~/dev/go/pkg && \
echo "# Env vars needed for GO" >> ~/.bashrc && \
echo "export GOROOT=/usr/local/go" >> ~/.bashrc && \
echo "export PATH=$PATH:$GOROOT/bin" >> ~/.bashrc && \
echo "export GOPATH=~/dev/go" >> ~/.bashrc && \
echo "# Env vars needed for GO" >> ~/.zshrc && \
echo "export GOROOT=/usr/local/go" >> ~/.zshrc && \
echo "export PATH=$PATH:$GOROOT/bin" >> ~/.zshrc && \
echo "export GOPATH=~/dev/go" >> ~/.zshrc && \

if [ $? -ne 0]; then
    echo -e "Failed to install go. Aborting\n"
    exit 1
else
    echo -e "Successfully installed go\n"
fi

echo -e "> install oh-my-zsh\n"
apt install -y zsh git-core && \
git clone 
git clone https://github.com/arsidada/oh-my-zsh.git ~/dev/oh-my-zsh && \
~/dev/oh-my-zsh/tools/install.sh && \
rm -rf ~/.zshrc && \
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
chsh -s `which zsh` && \
if [ $? -ne 0]; then
    echo -e "Failed to install oh-my-zsh. Aborting\n"
    exit 1
else
    echo -e "Successfully installed oh-my-zsh\n"
fi

curl -O https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz && \
tar -C /usr/local -xzf go1.10.linux-amd64.tar.gz &&\
rm -rf go1.10.linux-amd64.tar.gz

echo -e "All done! Please restart terminal."