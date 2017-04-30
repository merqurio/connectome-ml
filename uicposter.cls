\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uicposter}[]
\RequirePackage{tikz}
\RequirePackage{environ} % defines NewEnviron
\RequirePackage{graphicx}

%-------------------------------------------------------------------------------
% Information
%-------------------------------------------------------------------------------
% By Gabriel de Maeztu, gabriel.mp@uic.es
% Latest version at: http://github.com/merqurio/latex-uicbarcelona

% A poster class for \LaTeX that attempts to follow the UIC branding.
% This package is unofficial and is not supported by UIC Barcelona.

% Currently only compilation with XeLaTeX is supported.

%-------------------------------------------------------------------------------
% Variable setup
%-------------------------------------------------------------------------------
\makeatletter

% define important lengths
\newlength{\uicposter@bannerheight}
\setlength{\uicposter@bannerheight}{14cm}

\newlength{\uicposter@logoheight}
\setlength{\uicposter@logoheight}{5cm}

\newlength{\uicposter@margin}
\setlength{\uicposter@margin}{2cm}

% define important colors
\newcommand{\uicposter@color}{black}
\newcommand{\uicposter@foregroundcolor}{white}
\newcommand{\uicposter@size}{a0paper}

\newlength{\uicposter@logosize}
\setlength{\uicposter@logosize}{0.35\linewidth}


\makeatother

%-------------------------------------------------------------------------------
% Declare options
%-------------------------------------------------------------------------------
\RequirePackage{xkeyval}

\makeatletter

\DeclareOptionX{portrait}{
	\PassOptionsToPackage{portrait}{geometry}
	\setlength{\uicposter@bannerheight}{16cm}
}

\DeclareOptionX{landscape}{
	\PassOptionsToPackage{landscape}{geometry}
	\setlength{\uicposter@bannerheight}{8em}
}

\DeclareOptionX{bannerheight}{
	\setlength{\uicposter@bannerheight}{#1}
}

\DeclareOptionX{logoheight}{
	\setlength{\uicposter@logoheight}{#1}
}

\DeclareOptionX{margin}{
	\setlength{\uicposter@margin}{#1}
}

\DeclareOptionX{color}{
	\renewcommand{\uicposter@color}{#1}
}

\DeclareOptionX{inverttitle}{
	\renewcommand{\uicposter@foregroundcolor}{black}
}

\DeclareOptionX{size}{
	\renewcommand{\uicposter@size}{#1}
}

\makeatother

\ProcessOptionsX
\LoadClass{article}

%-------------------------------------------------------------------------------
% Set up paper geometry
%-------------------------------------------------------------------------------
\makeatletter
	\RequirePackage[\uicposter@size,margin=\uicposter@margin]{geometry}

	\setlength{\columnsep}{\uicposter@margin}
\makeatother

%-------------------------------------------------------------------------------
% Other required packages/definitions
%-------------------------------------------------------------------------------
\RequirePackage{multicol} % multiple columns

\pagenumbering{gobble} % remove page numbers

% font size
\renewcommand{\LARGE}{\fontsize{2em}{6em}\selectfont}
\renewcommand{\Large}{\fontsize{45}{50}\selectfont}
\renewcommand{\large}{\fontsize{35}{40}\selectfont}
\renewcommand{\normalsize}{\fontsize{30}{35}\selectfont}
\renewcommand{\footnotesize}{\fontsize{25}{35}\selectfont}
\renewcommand{\small}{\fontsize{20}{23}\selectfont}
\renewcommand{\tiny}{\fontsize{16}{18}\selectfont}

% paragraph options
\RequirePackage[none]{hyphenat} % no hyphenation
\setlength{\parindent}{0pt}
\newcommand{\defaultparskip}{1em}
\setlength{\parskip}{\defaultparskip}

% headings
\RequirePackage{titlesec}
\titlespacing{\section}{0pt}{\parskip}{-0.8\parskip}
\titlespacing{\subsection}{0pt}{\parskip}{-0.8\parskip}
\titlespacing{\subsubsection}{0pt}{\parskip}{-0.8\parskip}

% font
\RequirePackage{mathtools}
\RequirePackage{mathspec}
\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
\setallmainfonts{Helvetica}

%-------------------------------------------------------------------------------
% Official colours
%-------------------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{UIClightpurple}{cmyk}{0.08,0.25,0.04,0.14}
\definecolor{UICdarkpurple}{cmyk}{0.67,0.79,0.24,0.59}
\definecolor{UICpurple}{cmyk}{0.83,0.99,0.00,0.02}
\definecolor{UICblueceleste}{cmyk}{0.30,0.00,0.07,0.00}
\definecolor{UIClightblue}{cmyk}{0.42,0.07,0.08,0.08}
\definecolor{UICskyblue}{cmyk}{0.42,0.10,0.02,0.06}
\definecolor{UICbrightblue}{cmyk}{0.98,0.00,0.28,0.04}
\definecolor{UICnavyblue}{cmyk}{1.00,0.69,0.08,0.54}
\definecolor{UICdarkblue}{cmyk}{1.00,0.21,0.28,0.76}
\definecolor{UICdarkgreen}{cmyk}{0.35,0.30,1.00,0.75}
\definecolor{UICmidgreen}{cmyk}{0.42,0.05,0.98,0.29}
\definecolor{UICbrightgreen}{cmyk}{0.27,0.00,1.00,0.03}
\definecolor{UIClightgreen}{cmyk}{0.25,0.04,0.44,0.03}
\definecolor{UICstone}{cmyk}{0.03,0.04,0.14,0.08}
\definecolor{UICdarkgrey}{cmyk}{0.17,0.24,0.25,0.49}
\definecolor{UICdarkbrown}{cmyk}{0.30,0.71,0.75,0.81}
\definecolor{UICdarkred}{cmyk}{0.18,1.00,0.45,0.67}
\definecolor{UICburgundy}{cmyk}{0.00,0.97,0.89,0.45}
\definecolor{UICpink}{cmyk}{0.06,1.00,0.26,0.24}
\definecolor{UICrichred}{cmyk}{0.00,1.00,0.72,0.00}
\definecolor{UICmidred}{cmyk}{0.00,0.87,0.85,0.00}
\definecolor{UICorange}{cmyk}{0.00,0.61,0.99,0.00}
\definecolor{UICyellow}{cmyk}{0.00,0.29,1.00,0.00}
\definecolor{UICwhite}{cmyk}{0.00,0.00,0.00,0.00}
\definecolor{UICblack}{cmyk}{0.00,0.00,0.00,1.00}

%-------------------------------------------------------------------------------
% Make title/banner
%-------------------------------------------------------------------------------
\RequirePackage{eso-pic} % defines \AddToShipoutPicture
\RequirePackage{authblk} % affiliations

\makeatletter

% affiliations on one line
\renewcommand\AB@affilsepx{\hspace{0.5em}\protect\Affilfont}

% set lengths
\newlength{\uicposter@bannertextheight}
\setlength{\uicposter@bannertextheight}{\uicposter@bannerheight}
\addtolength{\uicposter@bannertextheight}{-2.0\uicposter@margin}

\newlength{\uicposter@bannertextwidth}
\setlength{\uicposter@bannertextwidth}{\paperwidth-20ex}

\renewcommand{\maketitle}{%
	% include banner
	\AddToShipoutPicture*{%
		\put(0,0){\parbox[b][\paperheight]{\paperwidth}{%
			\uicposter@banner%
			\vfill%
		}}%
	}%
	% include title
	\parbox[s][\uicposter@bannertextheight][s]{\uicposter@bannertextwidth}{%
		\color{\uicposter@foregroundcolor}\rmfamily\raggedright%
		{\LARGE\bfseries\addfontfeature{LetterSpace=3}\@title}%
		\par\vfill\vskip.5cm%
		{\Large\AB@authlist}%
		\par\vfill%
		{\normalsize\AB@affillist}%
	}%
	\vspace{-\parskip}%
	\vspace{1.5\uicposter@margin}%
}
\makeatother

%-------------------------------------------------------------------------------
% Highlightbox design
%-------------------------------------------------------------------------------

\makeatletter
\newlength{\uicposter@highlightboxpad}
\setlength{\uicposter@highlightboxpad}{0.2\uicposter@margin}

\NewEnviron{highlightbox}[1][\uicposter@color!20!white]{%
	\hspace*{-\uicposter@highlightboxpad}
	\colorbox{#1}{%
		\hspace*{\uicposter@highlightboxpad}%
		\begin{minipage}{\columnwidth}%
			\vspace*{\uicposter@highlightboxpad}%
			\begin{minipage}{\columnwidth}%
				\setlength{\parskip}{\defaultparskip}%
				\BODY%
			\end{minipage}%
			\vspace*{\uicposter@highlightboxpad}%
		\end{minipage}%
		\hspace*{\uicposter@highlightboxpad}%
	}%
	\hspace*{-\uicposter@highlightboxpad}%
	\par%
}
\makeatother

%-------------------------------------------------------------------------------
% Banner design
%-------------------------------------------------------------------------------
\makeatletter
\newcommand{\uicposter@banner}{
\begin{tikzpicture}[x=\uicposter@logoheight, y=\uicposter@logoheight,
					banner/.style={fill=\uicposter@color}]

	\fill[banner]
		(0, \uicposter@bannerheight) --
		(-\paperwidth, \uicposter@bannerheight) --
		(-\paperwidth, 0) --
		(0.000,0.000) -- cycle;

	\node[right, above, xshift=-.2\linewidth, yshift=-10]
    	{\includegraphics[width=.35\linewidth]{img/uic_logo}};

	\end{tikzpicture}
}
\makeatother

\endinput
