import re

def analyze_map_file(map_file_path):
    with open(map_file_path, 'r') as file:
        lines = file.readlines()

    # Extract Memory Regions
    memory_regions = {}
    for line in lines:
        match = re.match(r'(\w+)\s+0x(\w+)\s+0x(\w+)', line)
        if match:
            region, start, size = match.groups()
            memory_regions[region] = {'start': int(start, 16), 'size': int(size, 16)}

    # Extract Section Sizes
    section_sizes = {}
    for line in lines:
        match = re.match(r' (\.\w+)\s+0x\w+\s+0x(\w+)', line)
        if match:
            section, size = match.groups()
            section_sizes[section] = int(size, 16)

    # Print Memory Regions
    print("Memory Regions:")
    for region, values in memory_regions.items():
        print(f"  {region}: Start: 0x{values['start']:08X}, Size: {values['size']} bytes")

    # Print Section Sizes
    print("\nSection Sizes:")
    for section, size in section_sizes.items():
        print(f"  {section}: {size} bytes")

    # Calculate total used for major regions
    total_flash = sum(size for section, size in section_sizes.items() if '.text' in section or '.data' in section)
    total_ram = sum(size for section, size in section_sizes.items() if '.bss' in section or '.data' in section)

    print(f"\nTotal Flash Used: {total_flash} bytes")
    print(f"Total RAM Used: {total_ram} bytes")

if __name__ == "__main__":
    map_file_path = input("Enter the path to the memory map file: ")
    analyze_map_file(map_file_path)

