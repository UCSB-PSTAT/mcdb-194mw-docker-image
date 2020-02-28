# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# changed to mikebirdgeneau/jupyterlab:latest
FROM jupyter/scipy-notebook

LABEL maintainer="Patrick Windmiller <sysadmin@pstat.ucsb.edu>"

USER $NB_UID

RUN pip install ipympl && \
    jupyter labextension install jupyter-matplotlib && \
    jupyter labextension update --all

RUN conda install -c conda-forge spacy && \
    conda install -c conda-forge ipympl && \
    conda install --quiet -y nltk && \
    conda install --quiet -y mplcursors
#    conda clean -tipsy && \
#    fix-permissions $CONDA_DIR && \
#    fix-permissions /home/$NB_USER
    
# Adding language model to Spacy
RUN python -m spacy download en

RUN python -m spacy download en_core_web_md

RUN rm /opt/conda/share/jupyter/lab/extensions/jupyter-matplotlib-0.4.*

RUN pip install --upgrade jupyterlab && \
    jupyter-lab build
