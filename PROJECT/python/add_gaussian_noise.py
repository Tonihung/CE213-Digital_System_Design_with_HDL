import sys
from pathlib import Path
import cv2
import numpy as np

if len(sys.argv) != 3:
    print("Usage: python add_gaussian_noise.py <input_file> <output_file>")
    sys.exit(1)

python_dir = Path(__file__).resolve().parent

input_path = python_dir / "grayscale" / sys.argv[1]
output_path = python_dir / "add_noise" / sys.argv[2]

image = cv2.imread(str(input_path), cv2.IMREAD_GRAYSCALE)

if image is None:
    print(f"Cannot read: {input_path}")
    sys.exit(1)

noise = np.random.normal(0, 25, image.shape)
noisy_image = image.astype(np.float32) + noise
noisy_image = np.clip(noisy_image, 0, 255).astype(np.uint8)

output_path.parent.mkdir(parents=True, exist_ok=True)

if not cv2.imwrite(str(output_path), noisy_image):
    print(f"Cannot save: {output_path}")
    sys.exit(1)

print(f"Saved: {output_path}")