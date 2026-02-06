FROM runpod/worker-comfyui:5.5.1-base

# ComfyUI 버전 고정
RUN cd /comfyui && \
    git fetch && \
    git reset --hard fe251146

# 종속성 설치
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    -r /comfyui/requirements.txt \
    opencv-python-headless \
    gitpython \
    imageio-ffmpeg \
    ffmpeg-python

# 커스텀 노드 - 런팟과 동일한 버전
RUN git clone https://github.com/kijai/ComfyUI-KJNodes /comfyui/custom_nodes/ComfyUI-KJNodes && \
    cd /comfyui/custom_nodes/ComfyUI-KJNodes && \
    git reset --hard e8b70f2 && \
    pip install -r requirements.txt

RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite /comfyui/custom_nodes/ComfyUI-VideoHelperSuite && \
    cd /comfyui/custom_nodes/ComfyUI-VideoHelperSuite && \
    git reset --hard 993082e && \
    pip install -r requirements.txt

RUN git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts /comfyui/custom_nodes/ComfyUI-Custom-Scripts && \
    cd /comfyui/custom_nodes/ComfyUI-Custom-Scripts && \
    git reset --hard f2838ed

RUN git clone https://github.com/Lightricks/ComfyUI-LTXVideo /comfyui/custom_nodes/ComfyUI-LTXVideo && \
    cd /comfyui/custom_nodes/ComfyUI-LTXVideo && \
    git reset --hard 49add6d && \
    pip install -r requirements.txt

# 모델 다운로드
RUN comfy model download --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors --relative-path models/text_encoders --filename gemma_3_12B_it_fp4_mixed.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-distilled-fp8.safetensors --relative-path models/checkpoint --filename ltx-2-19b-distilled-fp8.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2-19b-LoRA-Camera-Control-Static/resolve/main/ltx-2-19b-lora-camera-control-static.safetensors --relative-path models/loras --filename ltx-2-19b-lora-camera-control-static.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2-19b-IC-LoRA-Detailer/resolve/main/ltx-2-19b-ic-lora-detailer.safetensors --relative-path models/loras --filename ltx-2-19b-ic-lora-detailer.safetensors
