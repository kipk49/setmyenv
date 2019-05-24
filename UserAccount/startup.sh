echo "Update Bashrc? (Append conda path, parse git branch, alias, etc.)"
select bashrc in "Yes" "No"; do
	case $bashrc in
		Yes ) break;;
No )  break;;
esac
done

echo "Install Cyclus Dependencies? (apt)"
select cyclus in "Yes" "No"; do
	case $cyclus in
		Yes ) break;;
No )  break;;
esac
done

echo "Setup Git?"
select github in "Yes" "No"; do
	case $github in
		Yes ) 
			sudo apt-get install git -y
			echo "Enter Git User Email";
			read email;
			ssh-keygen -t rsa -b 4096 -C $email;
			echo "Copy and Paste this for your ssh"
			echo "$(cat $HOME/.ssh/id_rsa.pub)"
			git config --global user.email $email;
			echo "Enter Git User Name";
			read name;
			git config --global user.name $name;
			break;;
No )  break;;
esac
done

if [[ $bashrc == "Yes" ]]; then
	cat toBash.txt >> $HOME/.bashrc;
	source $HOME/.bashrc;
	export PATH="$HOME/anaconda3/bin:$PATH"
fi

if [[ $cyclus == "Yes" ]]; then
	sudo apt-get update;
	sudo apt-get dist-upgrade -y
	sudo apt-get install -y cmake make libboost-all-dev libxml2-dev libxml++2.6-dev \
    libsqlite3-dev libhdf5-serial-dev libbz2-dev coinor-libcbc-dev coinor-libcoinutils-dev \
    coinor-libosi-dev coinor-libclp-dev coinor-libcgl-dev libblas-dev liblapack-dev g++ \
    libgoogle-perftools-dev python-dev python-tables python-pandas python-numpy python-nose \
    python-jinja2 cython
    sudo apt-get install python-pip
    pip install cython
fi