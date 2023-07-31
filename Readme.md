# Simple OCR that converts PDF into word

## Installation
### On Mac OS
1. install tesseract
```
brew install tesseract
```
2. Get required language data from (tesseract-data)[https://tesseract-ocr.github.io/tessdoc/Data-Files]
To get polish language data (`pol` lang)for example download it into your tessdata directory:
```
wget https://github.com/tesseract-ocr/tessdata/raw/4.00/pol.traineddata -O /usr/local/share/tessdata/pol.traineddata
```
3. Install poetry
4. install project dependencies
```
poetry install
```
5. activate virtual environment
```
poetry shell
```

## Usage
Default language used by script is `pol`(polish). Other languages for OCR can be specified in `--lang` option parameter
Example usage for polish written PDF:
```
./pdf2word intput_file.pdf output_file.docx
```

Example usage for english written PDF:
```
./pdf2word --lang eng intput_file.pdf output_file.docx
```

Help:
```
./pdf2word --help
```