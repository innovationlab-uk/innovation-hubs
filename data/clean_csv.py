"""
Author: Sirvan Almasi @ ICL
License: MIT
"""
import csv, argparse, os.path

def clean_csv(in_file, out_file, illegal_chars):
    """Strip and remove unwanted characters from CSV file"""
    if illegal_chars is None:
        illegal_chars = ['\n', '\t', '"']
    # TODO: implement delimiter and quotechar properly for each
    in_reader = csv.reader(in_file, delimiter=',', quotechar='"')
    out_writer = csv.writer(out_file, delimiter=',',
                    quotechar='"',
                    quoting=csv.QUOTE_MINIMAL)
    new_data = []
    for i, row in enumerate(in_reader):
        new_data.append(row)
        for j, cell in enumerate(row):
            clean_cell = cell.strip()
            for char in illegal_chars:
                clean_cell = clean_cell.replace(char, '').strip()
            new_data[i][j] = clean_cell
        out_writer.writerow(new_data[i])
    out_file.close()
    return True


def is_valid_file(parser, arg):
    if not os.path.exists(arg):
        print("The file %s does not exist! creating new file." % arg)
    try:
        return open(arg, mode='w')
    except:
        return parser.error('Could not creaate a new file!')

def main():
    # TODO: Implement args properly
    parser = argparse.ArgumentParser(description='Clean your CSV file')
    parser.add_argument('file',
                        metavar='CSV_FILE_IN',
                        type=argparse.FileType('r'),
                        nargs='*',
                        help='Your input CSV file.')

    parser.add_argument('out',
                        metavar='CSV_FILE_OUT',
                        type=lambda x: is_valid_file(parser, x),
                        help='Your output CSV file.')

    parser.add_argument('-d', '--delimiter',
                        metavar='DELIMITER',
                        type=str,
                        default=',',
                        help='delimiter character. Default is \',\'')

    parser.add_argument('-q',
                        '--quotechar',
                        metavar='QUOTECHAR',
                        type=str,
                        default='"',
                        help='quotation character. Default is \'"\'')
    args = parser.parse_args()

    return clean_csv(args.file[0], args.out, None)
if __name__ == "__main__":
    if main():
        print('Your file has been created.')