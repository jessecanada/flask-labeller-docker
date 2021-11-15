# Define base image
FROM continuumio/miniconda3

# add everything in the current folder into "flask_labeller" directory in the image
ADD . /flask_labeller

# Set working directory for the project
WORKDIR /flask_labeller
 
# fix openCV issues
RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx

# Create Conda environment from the YAML file. The name of the environment is called "path_view" (1st line of yml file)
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "path_view", "/bin/bash", "-c"]

# Activate Conda environment and check if it is working properly
RUN echo "Making sure flask is installed correctly..."
RUN python -c "import flask"

EXPOSE 5000

# Python program to run in the container
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "path_view", \
            "python", "-m", "image_labelling_tool.flask_labeller", \
            "--enable_dextr" \
            #"--dextr_weights=dextr_model/dextr_OD.pth" \
            ]