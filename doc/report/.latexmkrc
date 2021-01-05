$latex = 'latex  %O  --shell-escape %S';
$pdflatex = 'pdflatex  %O  --shell-escape %S';
$ENV{'TEXINPUTS'}='../../latex-files:llncs2e:' . $ENV{'TEXINPUTS'};