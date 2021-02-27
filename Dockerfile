# Details of the base image are here: hub.docker.com/r/jupyter/scipy-notebook
# Tag [2ce7c06a61a1] is latest image as of August 12, 2019
# It runs Python 3.7.3

FROM jupyter/scipy-notebook:2ce7c06a61a1

MAINTAINER Jon Krohn <jon@untapt.com>

USER $NB_USER

# Install TensorFlow:
RUN pip install tensorflow==2.0.0

# Install PyTorch libraries:
RUN pip install https://download.pytorch.org/whl/cpu/torch-1.0.1.post2-cp37-cp37m-linux_x86_64.whl
RUN pip install torchvision==0.4.0
RUN pip install torchsummary==1.5.1

# Install NLP libraries:
RUN pip install nltk==3.4.5
RUN pip install gensim==3.8.1
RUN pip install spacy==2.2.1
RUN python -m spacy download en_core_web_sm

# Install Reinforcement Learning library:
RUN pip install gym==0.12.5

# Install for Object Detection notebook:
RUN pip install opencv-python==4.1.2.30

RUN python -m pip install jupyterthemes
RUN python -m pip install --upgrade jupyterthemes
RUN python -m pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user
# enable the Nbextensions
RUN jupyter nbextension enable contrib_nbextensions_help_item/main
RUN jupyter nbextension enable autosavetime/main
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable code_font_size/code_font_size
RUN jupyter nbextension enable code_prettify/code_prettify
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable comment-uncomment/main
RUN jupyter nbextension enable equation-numbering/main
RUN jupyter nbextension enable execute_time/ExecuteTime
RUN jupyter nbextension enable gist_it/main
RUN jupyter nbextension enable hide_input/main
RUN jupyter nbextension enable spellchecker/main
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable toggle_all_line_numbers/main

RUN pip install jupyterhub
RUN pip install ipysheet
RUN pip install jupyterlab-git
RUN pip install voila
RUN pip install plotly
RUN pip install dash
RUN pip install bokeh
RUN pip install jupyter_bokeh
RUN pip install jupyterlab_latex
RUN pip install dockerspawner
RUN pip install oauthenticator
RUN pip install cufflinks
RUN pip install algorithmx

jupyter labextension install @axlair/jupyterlab_vim
jupyter labextension install @jupyterlab/latex
jupyter labextension install ipysheet
jupyter labextension install @jupyterlab/git
jupyter labextension install jupyterlab-plotly
jupyter labextension install @jupyterlab/hub-extension
jupyter labextension install @telamonian/theme-darcula
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install algorithmx-jupyter
jupyter labextension install @bokeh/jupyter_bokeh
jupyter labextension install @pyviz/jupyterlab_pyviz
jupyter labextension install @jupyterlab/toc
jupyter serverextension enable --py jupyterlab_git

USER root
RUN apt-get update && \
	apt-get install -yq --no-install-recommends \
		texlive-latex-recommended \
		texlive-lang-english \
		texlive-lang-european \
		texlive-lang-german \
		texlive-pstricks \
		openssh-client \
		tmux \
		vim \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

USER $NB_USER
RUN pip install requests
RUN pip install arrow
RUN pip install dateutils
RUN pip install webdavclient3
RUN pip install webdavclient

ADD jupyterhub_config.py /home/$NB_USER/.jupyter/
ADD jupyter_notebook_config.py /home/$NB_USER/.jupyter/
