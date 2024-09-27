Triton Inference Server can be executed on AMD GPUs with the PyTorch backend. This enablement on AMD GPUs has been implemented in version 23.10 of Triton Inference Server, and has been tested on AMD MI210, MI250 and MI300x GPUs.

To build the Triton + PyTorch docker container, execute the following command:

```
python3 build.py --no-container-pull --enable-logging --enable-stats \

  --enable-tracing --enable-rocm  --endpoint=grpc \

  --image gpu-base,rocm/pytorch:rocm6.0.2_ubuntu22.04_py3.10_pytorch_2.1.2 \

  --endpoint=http --backend=pytorch
```

If your system uses podman instead of docker, use the build script build-podman.py

Once the container is built, you are ready to run the server. The docker command below can be used to launch Triton Inference Server on AMD GPUs:

```
docker run -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \

  --security-opt label=disable --device=/dev/kfd --device=/dev/dri --group-add video \

  --ipc=host --name tritonserver --rm -p 8001:8001 -p 8000:8000 \

  -e LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/conda/envs/py_3.10/lib/ \

  -v <path to your work directory>:/work -w /work <docker image ID> \

        tritonserver --model-store <path to model repository>
```

