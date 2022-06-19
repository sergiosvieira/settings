 #!/bin/bash
 
 
 
 # Basic tools
 if ! command -v vim &> /dev/null
 then
 	sudo dnf -y install vim 
 fi
 
 # Snap, Qtcreator
 if ! command -v snap &> /dev/null
 then
 	sudo dnf -y install snapd gcc g++ llvm cmake
   	sudo ln -s /var/lib/snapd/snap /snap
 	sudo snap install qtcreator-ros --classic
 fi
 
 # Netbeans
 if ! command -v javac &> /dev/null
 then
	 sudo dnf -y install java-17-openjdk  java-17-openjdk-devel
	 curl -O https://dlcdn.apache.org/netbeans/netbeans-installers/13/Apache-NetBeans-13-bin-linux-x64.sh
	 chmod +x Apache-NetBeans-13-bin-linux-x64.sh
	 sudo ./Apache-NetBeans-13-bin-linux-x64.sh
 fi
 
 # Visual Studio Code
 if ! command -v code &> /dev/null
 then
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	if [ -f "/etc/yum.repos.d/vscode.repo" ]
	then
		sudo rm /etc/yum.repos.d/vscode.repo
	fi
	printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
	sudo dnf install -y code
 fi
 
# Aplicativos
sudo dnf install -y chromium inkscape gimp plantuml eclipse

FILE=dbeaver-ce-latest-stable.x86_64.rpm
if [ ! -f "$FILE" ]
then
	wget https://dbeaver.io/files/$FILE
	sudo rpm -Uvh ./$FILE
fi

FILE=eclipse-inst-jre-linux64.tar.gz
if [ ! -f "$FILE" ]
then
	wget https://mirror.umd.edu/eclipse/oomph/epp/2022-03/R/$FILE
	tar -xzvf $FILE
	cd eclipse-installer/
	./eclipse-inst
fi

flatpak install --user https://flathub.org/repo/appstream/com.sublimetext.three.flatpakref
