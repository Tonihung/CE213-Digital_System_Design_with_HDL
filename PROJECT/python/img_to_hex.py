import sys
from pathlib import Path
import cv2

if len(sys.argv) != 3:
    print("Usage: python img_to_hex.py <input_file> <output_file>")
    sys.exit(1)

python_dir = Path(__file__).resolve().parent

input_path = python_dir / "add_noise" / sys.argv[1]
output_path = python_dir / "hex_input" / sys.argv[2]

image = cv2.imread(str(input_path), cv2.IMREAD_GRAYSCALE)

if image is None:
    print(f"Cannot read: {input_path}")
    sys.exit(1)

image = cv2.resize(image, (256, 256))
output_path.parent.mkdir(parents=True, exist_ok=True)

with output_path.open("w", encoding="utf-8") as file:
    for pixel in image.flatten():
        file.write(f"{int(pixel):02X}\n")

print(f"Saved: {output_path}")