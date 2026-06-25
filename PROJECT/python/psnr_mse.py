import sys
import math
from pathlib import Path
import cv2
import numpy as np

if len(sys.argv) != 3:
    print("Usage: python psnr_mse.py <reference_file> <filtered_file>")
    sys.exit(1)

python_dir = Path(__file__).resolve().parent
project_dir = python_dir.parent

reference_path = python_dir / "grayscale" / sys.argv[1]
filtered_path = project_dir / "output" / sys.argv[2]

reference = cv2.imread(str(reference_path), cv2.IMREAD_GRAYSCALE)
filtered = cv2.imread(str(filtered_path), cv2.IMREAD_GRAYSCALE)

if reference is None:
    print(f"Cannot read: {reference_path}")
    sys.exit(1)

if filtered is None:
    print(f"Cannot read: {filtered_path}")
    sys.exit(1)

if reference.shape != filtered.shape:
    print(
        f"Image sizes do not match: "
        f"{reference.shape} and {filtered.shape}"
    )
    sys.exit(1)

difference = reference.astype(np.float64) - filtered.astype(np.float64)
mse = np.mean(difference ** 2)

if mse == 0:
    psnr = math.inf
else:
    psnr = 10 * math.log10((255.0 ** 2) / mse)

print(f"MSE: {mse:.6f}")

if math.isinf(psnr):
    print("PSNR: Infinity")
else:
    print(f"PSNR: {psnr:.6f} dB")