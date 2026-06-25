````markdown
# Python Image Processing Tools

These Python scripts are used to prepare input images and process the output of the Gaussian filter.

## Installation

```bash
pip install opencv-python numpy
````

Run all commands inside:

```text
PROJECT/python
```

## Usage

### Convert an image to grayscale

Input: `PROJECT/input/`
Output: `python/grayscale/`

```bash
python convert_to_grayscale.py input.jpg grayscale.png
```

### Add Gaussian noise

Input: `python/grayscale/`
Output: `python/add_noise/`

```bash
python add_gaussian_noise.py grayscale.png noisy.png
```

### Convert an image to HEX

Input: `python/add_noise/`
Output: `python/hex_input/`

```bash
python img_to_hex.py noisy.png input.hex
```

### Convert HEX to an image

Input: `python/hex_output/`
Output: `PROJECT/output/`

```bash
python hex_to_img.py output.hex filtered.png
```

### Calculate MSE and PSNR

Reference image: `python/grayscale/`
Filtered image: `PROJECT/output/`

```bash
python psnr_mse.py grayscale.png filtered.png
```

## Complete Workflow

```bash
python convert_to_grayscale.py input.jpg grayscale.png
python add_gaussian_noise.py grayscale.png noisy.png
python img_to_hex.py noisy.png input.hex
python hex_to_img.py output.hex filtered.png
python psnr_mse.py grayscale.png filtered.png