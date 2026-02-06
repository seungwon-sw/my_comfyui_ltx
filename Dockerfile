# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Could not resolve custom node: ImageResizeKJv2 (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXAVTextEncoderLoader (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVConditioning (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVPreprocess (unknown registry, no aux_id provided)
# Could not resolve custom node: EmptyLTXVLatentVideo (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVImgToVideoInplace (unknown registry, no aux_id provided)
# Could not resolve custom node: ConditioningZeroOut (unknown registry, no aux_id provided)
# Could not resolve custom node: ManualSigmas (unknown registry, no aux_id provided)
# Could not resolve custom node: CFGGuider (unknown registry, no aux_id provided)
# Could not resolve custom node: ResizeImagesByLongerEdge (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVConcatAVLatent (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVAudioVAEEncode (unknown registry, no aux_id provided)
# Could not resolve custom node: SolidMask (unknown registry, no aux_id provided)
# Could not resolve custom node: PrimitiveFloat (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVAudioVAELoader (unknown registry, no aux_id provided)
# Could not resolve custom node: MathExpression|pysssss (unknown registry, no aux_id provided)
# Could not resolve custom node: SetLatentNoiseMask (unknown registry, no aux_id provided)
# Could not resolve custom node: LoraLoaderModelOnly (unknown registry, no aux_id provided)
# Could not resolve custom node: VAEDecodeTiled (unknown registry, no aux_id provided)
# Could not resolve custom node: LTXVSeparateAVLatent (unknown registry, no aux_id provided)
# Could not resolve custom node: CheckpointLoaderSimple (unknown registry, no aux_id provided)
# Could not resolve custom node: CreateVideo (unknown registry, no aux_id provided)
# Could not resolve custom node: GetImageSize (unknown registry, no aux_id provided)
# Could not resolve custom node: SaveVideo (unknown registry, no aux_id provided)
# Could not resolve custom node: LoraLoaderModelOnly (unknown registry, no aux_id provided)
# Could not resolve custom node: VHS_LoadAudioUpload (unknown registry, no aux_id provided)
# Could not resolve custom node: GetImageSizeAndCount (unknown registry, no aux_id provided)

# install custom nodes
RUN comfy node install comfyui-kjnodes
RUN comfy node install ComfyUI-VideoHelperSuite
RUN comfy node install ComfyUI-Custom-Scripts
RUN comfy node install ComfyUI-Impact-Pack
RUN comfy node install ComfyUI-LTXVideo

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors --relative-path models/text_encoders --filename gemma_3_12B_it_fp4_mixed.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-distilled-fp8.safetensors --relative-path models/checkpoint --filename ltx-2-19b-distilled-fp8.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2-19b-LoRA-Camera-Control-Static/resolve/main/ltx-2-19b-lora-camera-control-static.safetensors --relative-path models/loras --filename ltx-2-19b-lora-camera-control-static.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2-19b-IC-LoRA-Detailer/resolve/main/ltx-2-19b-ic-lora-detailer.safetensors --relative-path models/loras --filename ltx-2-19b-ic-lora-detailer.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
