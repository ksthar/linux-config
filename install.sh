#!/bin/bash

cd $HOME
rm .bashrc
ln -s linux-config/.bashrc .bashrc
source .bashrc
