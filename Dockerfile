# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# ComfyUI 최신 버전으로 업데이트
RUN cd /comfyui && git fetch origin && git reset --hard fe251146

# core requirements + 추가 요청 패키지(opencv, ffmpeg 등)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    -r /comfyui/requirements.txt \
    opencv-python-headless \
    gitpython \
    imageio-ffmpeg \
    ffmpeg-python

# install custom nodes
RUN comfy node install ComfyUI-KJNodes
RUN comfy node install ComfyUI-VideoHelperSuite
RUN comfy node install ComfyUI-Custom-Scripts
RUN comfy node install ComfyUI-LTXVideo

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors --relative-path models/text_encoders --filename gemma_3_12B_it_fp4_mixed.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-distilled-fp8.safetensors --relative-path models/checkpoint --filename ltx-2-19b-distilled-fp8.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2-19b-LoRA-Camera-Control-Static/resolve/main/ltx-2-19b-lora-camera-control-static.safetensors --relative-path models/loras --filename ltx-2-19b-lora-camera-control-static.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2-19b-IC-LoRA-Detailer/resolve/main/ltx-2-19b-ic-lora-detailer.safetensors --relative-path models/loras --filename ltx-2-19b-ic-lora-detailer.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
