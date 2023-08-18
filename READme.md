For Master Node:

1) Remove any unwanted DNS servers
2) Open Firefox, navigate to https://tinyurl.com/yc5m2yss
3) Download initial-setup-master.sh
4) Open terminal
-cd Downloads/
-sudo chmod +x initial-setup-master.sh
-sudo ./initial-setup-master.sh
5) Open second instance of terminal (right click terminal in upper left corner, click 'New Window)
-cd Downloads/
-python3 -m http.server
**Note** If in a hurry, you can move from here to the worker nodes
6) Once original terminal is finished running
-copy and run the three commands to make the home directory for K8s (inside of output)
7)Open Files (icon under Firefox in this env)-->Downloads-->initial-setup-master.sh
8)Copy the last command in the .sh file (begins with kubectl apply -f). Be sure not to copy any "#" or any other characters, but grab the whole URL
9)Paste the command into the terminal
-kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
10)Check node status
-kubectl get nodes

For Worker Nodes:

1) Remove any unwanted DNS servers
2) Open Firefox, navigate to https://tinyurl.com/yc5m2yss
3) Download initial-setup-worker.sh
4) Open terminal
-cd Downloads/
-sudo chmod +x initial-setup-worker.sh
-sudo initial-setup-worker.sh
5) Open second tab in Firefox, navigate to http://ub01:8000
6) Once the initial setup is complete:
    6a. On Firefox open k8sjoin.txt
    6b. Copy ONLY the text after 'kubeadmin' (make sure you grab ALL of the text after that keyword)
    6c. Paste the command into Terminal (ensure you type 'sudo' before the command)
7) Navigate back to Master Node VM. Run kubectl get nodes to ensure the worker node is under the master. 
8) Repeat for any other worker nodes. 