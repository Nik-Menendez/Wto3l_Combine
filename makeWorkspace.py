import glob,os,argparse

parser = argparse.ArgumentParser()
parser.add_argument("--inputDir",action="store")
parser.add_argument("--pattern",action="store",default="window_*.txt")

option = parser.parse_args()

inputDir = option.inputDir
pattern = option.pattern

for textFileName in glob.glob(inputDir+pattern):
    print "*"*20
    print "Making workspace from", textFileName
    cmd = "text2workspace.py "+textFileName+" -v 1 --no-b-only"
    os.system(cmd)
