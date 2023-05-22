inputDir=data/DataCards/
outputDir=outputs/
#inputDir=data/ZDataCards/
#outputDir=outputsZ/

plotName=iso_20Pre_NewSig
plotDir=plots/${plotName}/
plotPath=${plotDir}UpperLimitPlot.pdf

rm data/DataCards/*
cp /orange/avery/nikmenendez/Wto3l/Optimizer/DataCards/datacard_M*.txt data/DataCards/

python makeWorkspace.py --inputDir=${inputDir} --pattern="datacard_M*.txt"
#python makeWorkspace.py --inputDir=${inputDir} --pattern="ZpToMuMu_M*.txt"

rm -r ${outputDir}
mkdir ${outputDir}
for entry in "${inputDir}"*.root
do
	echo "Aquiring Limits of" $entry
	mass=$(cut -d "_" -f2 <<< "$entry")
	combine -M AsymptoticLimits $entry -t -1 --run=blind
	output="${outputDir}higgsCombineTest.AsymptoticLimits.${mass}"
	echo $output
	mv higgsCombineTest.AsymptoticLimits.mH120.root $output
done

python plotLimit.py --inputDir=${outputDir} --outputPath=${plotPath}
display ${plotDir}UpperLimitPlot_r.pdf 

echo "scp ${plotDir}*.pdf nimenend@lxplus.cern.ch:/eos/user/n/nimenend/www/Wto3l/SR_Selection/UL/datacards_RBE_${plotName}/"
scp ${plotDir}*.pdf nimenend@lxplus.cern.ch:/eos/user/n/nimenend/www/Wto3l/SR_Selection/UL/datacards_RBE_${plotName}/

