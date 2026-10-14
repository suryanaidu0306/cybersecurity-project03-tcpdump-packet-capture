#!/bin/bash

echo "======================================"
echo "       TCPDUMP PACKET CAPTURE"
echo "======================================"

INTERFACE="lo"
CAPTURE_FILE="capture.pcap"
OUTPUT_FILE="output.txt"

echo "Interface: $INTERFACE"
echo "Capture file: $CAPTURE_FILE"
echo

if ! command -v tcpdump >/dev/null 2>&1; then
    echo "Error: tcpdump is not installed."
    exit 1
fi

echo "Capturing 20 packets..."
echo "Generate traffic in another terminal if needed."
echo

sudo tcpdump -i "$INTERFACE" -c 20 \
    -w "$CAPTURE_FILE"

if [ $? -eq 0 ]; then
    echo
    echo "Capture completed successfully."
    echo "Saved to: $CAPTURE_FILE"

    echo
    echo "Reading saved packet summary..."

    tcpdump -nn -r "$CAPTURE_FILE" > "$OUTPUT_FILE" 2>&1

    cat "$OUTPUT_FILE"
    echo
    echo "Packet summary saved to: $OUTPUT_FILE"
else
    echo "Capture failed. Check permissions and interface name."
    exit 1
fi

