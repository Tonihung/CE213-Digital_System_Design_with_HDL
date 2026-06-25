import sys
from pathlib import Path
import cv2
import numpy as np

if len(sys.argv) != 3:
    print("Usage: python hex_to_img.py <input_file> <output_file>")
    sys.exit(1)

python_dir = Path(__file__).resolve().parent
project_dir = python_dir.parent

input_path = python_dir / "hex_output" / sys.argv[1]
output_path = project_dir / "output" / sys.argv[2]

if not input_path.is_file():
    print(f"Cannot read: {input_path}")
    sys.exit(1)

try:
    values = []

    with input_path.open("r", encoding="utf-8") as file:
        for line in file:
            values.extend(line.split())

    pixels = np.array(
        [int(value, 16) for value in values],
        dtype=np.uint8
    )
except ValueError:
    print("Invalid HEX data")
    sys.exit(1)

if pixels.size != 256 * 256:
    print(f"Expected 65536 pixels, found {pixels.size}")
    sys.exit(1)

image = pixels.reshape(256, 256)
output_path.parent.mkdir(parents=True, exist_ok=True)

if not cv2.imwrite(str(output_path), image):
    print(f"Cannot save: {output_path}")
    sys.exit(1)

print(f"Saved: {output_path}")