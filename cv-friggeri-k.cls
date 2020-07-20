\ProvidesClass{friggeri-cv}[2016/01/01 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{lightheader}{\def\@cv@lightheader{}}

\DeclareOption{nocolors}{\def\@cv@nocolors{}}

\DeclareOption{nobackground}{\def\@cv@nobackground{}}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

% Add support for A4 paper
\newif\ifafourpaper

\afourpaperfalse

\newlength{\inlength}
\setlength{\inlength}{11.6cm}

\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}%
    \setlength\inlength {11.1cm}%
    \afourpapertrue%
   }

\ProcessOptions\relax
\LoadClass{article}


%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{39393A}
\definecolor{gray}{HTML}{636362}
\definecolor{lightgray}{HTML}{999999}

\definecolor{c0}{HTML}{3A6EA5}
\definecolor{c1}{HTML}{A17DA0}
\definecolor{c2}{HTML}{C14953}
\definecolor{c3}{HTML}{D8CD83}
\definecolor{c4}{HTML}{297373}
\definecolor{c5}{HTML}{372248}

\ifdefined\@cv@nocolors
\colorlet{c0}{gray}
\colorlet{c1}{gray}
\colorlet{c2}{gray}
\colorlet{c3}{gray}
\colorlet{c4}{gray}
\colorlet{c5}{gray}
\fi

\ifdefined\@cv@lightheader
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else 
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi

\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX]{unicode-math}

\newfontfamily\bodyfont[]{Roboto}
\newfontfamily\thinfont[]{Roboto Thin}
\newfontfamily\headingfont[]{Roboto Condensed Bold}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{Roboto Light}

%\setmathfont{XITS Math}

%%%%%%%%%%%%%%
% Background %
%%%%%%%%%%%%%%

\newcommand{\background}[1]{%
  \ifx \@cv@nobackground \undefined
    \tikz[remember picture,overlay] \node[opacity=0.8,inner sep=0pt] at (current page.center){\includegraphics[width=\paperwidth,height=\paperheight]{#1}};%
  \fi
}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm, opacity=0.55] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      c\the\value{colorCounter}%
    } #1#2#3%
  }%
  \ifnum\value{colorCounter}=5%
    \setcounter{colorCounter}{0}%
  \else%
    \stepcounter{colorCounter}%
  \fi%
}

\newcounter{skillColorCounter}
\def\@skillcolor{%
  c\the\value{skillColorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}%
  {\Large\headingfont\color{headercolor} #1}
  \par\vspace{.25\parskip}%
}

\renewcommand{\subsubsection}[2]{
  \par\vspace{.5\parskip}%
  {\Large\headingfont\color{headercolor} #2}
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}

\newenvironment{notabentrylist}{%
  \begin{description}
}{%
  \end{description}
}

\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  \parbox[t]{2cm}{\hfill#1}&\parbox[t]{\inlength}{%
    \textbf{#2}%
    \hfill%
    {\normalsize\addfontfeature{Color=lightgray} \textit{#3}}\\%
    #4\vspace{\parsep}%
}\\}

\newcommand{\notabentry}[2]{%
  \item%
  [\textbf{#1}]%
  #2\vspace{\parsep}%
}

%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(1.5, 4.33)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

\RequirePackage{progressbar}
\newcommand{\skill}[2]{
#1
\noindent%
\progressbar[width=38mm, linecolor=darkgray, borderwidth=0.3mm, tickscolor=darkgray, roundnessr=0.55, filledcolor=\@skillcolor]{#2}
\ifnum\value{skillColorCounter}=5%
  \setcounter{skillColorCounter}{0}%
\else%
  \stepcounter{skillColorCounter}%
\fi%
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[backend=biber, style=verbose, maxnames=99, sorting=ydnt]{biblatex}

\DeclareFieldFormat[article]{title}{\href{\thefield{url}}{#1}}
\DeclareFieldFormat[inproceedings]{title}{\href{\thefield{url}}{#1}}
\DeclareFieldFormat[book]{title}{\href{\thefield{url}}{#1}}
\DeclareFieldFormat[misc]{title}{\href{\thefield{url}}{#1}}
\DeclareFieldFormat[report]{title}{\href{\thefield{url}}{#1}}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{book}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}


\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    \printfield{booktitle}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{booktitle}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{report}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{type}%
    \setunit{\space}%
    \printfield{number}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareNameFormat{author}{%
  \small\addfontfeature{Color=lightgray}%
  \nameparts{#1}\ifblank{\namepartgiven}{}{\namepartgiven\space}\namepartfamily%
  \ifthenelse{\value{listcount}<\value{liststop}}
    {\addcomma\space}
    {}%
}

\defbibheading{bibheading}[\bibname]{%
   \subsubsection*{#1}
   \markboth{#1}{#1}
}

\newcommand{\printbibsection}[2]{
  \begin{refsection}
    \nocite{*}
    \printbibliography[sorting=chronological, type={#1}, title={#2}, heading=bibheading]
  \end{refsection}
}

\DeclareSortingScheme{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}



%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=1.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
	hidelinks,
	%colorlinks,
	linkcolor=c2,
	citecolor=c2,
	filecolor=c2,
	urlcolor = c0
}

% A fix for \href{}{} colors not working with fontspec
\makeatletter
\def\HyColor@@@@UseColor#1\@nil{\addfontfeatures{Color=#1}}
\makeatother

